import React, { useState, useRef, useEffect, useCallback } from "react";
import ReactMarkdown from "react-markdown";
import remarkGfm from "remark-gfm";
import useAuth from "../hooks/useAuth";
import useIntent from "../hooks/useIntent";
import useMessageGuard from "../hooks/useMessageGuard";
import mapIntents from "../../services/mapIntents";
import QuotaStatus from "./QuotaStatus";
import MessageGuardModal from "./MessageGuardModal";
import { shouldAppendToken } from "../utils/streaming";
import {
  applyChatErrorToMessages,
  parseChatError,
  parseSseChatError,
} from "../utils/chatErrors";
import {
  AUTO_INTENT_OPTION,
  formatIntentConfidence,
  hasIntentClassificationDetails,
} from "../utils/intentClassification";
import { API_BASE } from "../api/client";

// ── Blinking cursor keyframe injected once at module level ────────────────
const CURSOR_STYLE = `
@keyframes ai-blink {
  0%, 100% { opacity: 1; }
  50%       { opacity: 0; }
}
.ai-cursor {
  display: inline-block;
  width: 2px;
  height: 0.9em;
  background: var(--accent-primary, #7c3aed);
  margin-left: 2px;
  border-radius: 1px;
  vertical-align: text-bottom;
  animation: ai-blink 0.9s step-end infinite;
}
`;

// Resolved-sensitivity visual theme (PII scan / upgrade indicators)
const SENSITIVITY_THEME = {
  HIGH: {
    bg: "#ef4444",
    softBg: "rgba(239, 68, 68, 0.12)",
    border: "rgba(239, 68, 68, 0.35)",
    text: "#f87171",
  },
  MEDIUM: {
    bg: "#eab308",
    softBg: "rgba(234, 179, 8, 0.12)",
    border: "rgba(234, 179, 8, 0.35)",
    text: "#facc15",
  },
  LOW: {
    bg: "#22c55e",
    softBg: "rgba(34, 197, 94, 0.12)",
    border: "rgba(34, 197, 94, 0.35)",
    text: "#4ade80",
  },
};

function getSensitivityTheme(level) {
  const key = String(level || "LOW").toUpperCase();
  return SENSITIVITY_THEME[key] ?? SENSITIVITY_THEME.LOW;
}

const AIChat = ({
  logout,
  fetchAdmin,
  fetchDocuments,
  loading,
  error,
  documents,
  isAdmin,
  onOpenAdmin,
}) => {
  const { token } = useAuth();
  
  const [isDarkMode, setIsDarkMode] = useState(() => !document.body.classList.contains("light-theme"));

  useEffect(() => {
    if (isDarkMode) {
      document.body.classList.remove("light-theme");
    } else {
      document.body.classList.add("light-theme");
    }
  }, [isDarkMode]);

  const initialMessage = {
    role: "assistant",
    content: "Hello! I am your AI assistant. How can I help you today?",
    timestamp: new Date().toLocaleTimeString([], {
      hour: "2-digit",
      minute: "2-digit",
    }),
  };

  const [chats, setChats] = useState([{
    id: Date.now(),
    title: "New Chat",
    messages: [initialMessage]
  }]);
  
  const [currentChatId, setCurrentChatId] = useState(chats[0].id);
  const [messages, setMessages] = useState(chats[0].messages);
  const [activeTool, setActiveTool] = useState("chat"); // chat, library, ide, shell

  // Sync messages to the current chat and generate title from the first prompt
  useEffect(() => {
    setChats((prevChats) =>
      prevChats.map((chat) => {
        if (chat.id === currentChatId) {
          let newTitle = chat.title;
          if (newTitle === "New Chat" && messages.length > 1) {
            const firstUserMsg = messages.find((m) => m.role === "user");
            if (firstUserMsg) {
              const words = firstUserMsg.content.split(" ");
              newTitle = words.slice(0, 5).join(" ");
              if (words.length > 5) newTitle += "...";
            }
          }
          return { ...chat, title: newTitle, messages: messages };
        }
        return chat;
      })
    );
  }, [messages, currentChatId]);

  const createNewChat = () => {
    const newId = Date.now();
    const initialMsgs = [{ ...initialMessage }];
    setChats((prev) => [{ id: newId, title: "New Chat", messages: initialMsgs }, ...prev]);
    setCurrentChatId(newId);
    setMessages(initialMsgs);
  };

  const deleteChat = (id) => {
    setChats((prev) => {
      const updated = prev.filter((c) => c.id !== id);
      if (updated.length === 0) {
        const newId = Date.now();
        const initialMsgs = [{ ...initialMessage }];
        setCurrentChatId(newId);
        setMessages(initialMsgs);
        return [{ id: newId, title: "New Chat", messages: initialMsgs }];
      } else if (id === currentChatId) {
        setCurrentChatId(updated[0].id);
        setMessages(updated[0].messages);
      }
      return updated;
    });
  };

  const selectChat = (id) => {
    const chat = chats.find((c) => c.id === id);
    if (chat) {
      setCurrentChatId(id);
      setMessages(chat.messages);
    }
  };
  const [input, setInput] = useState("");
  const [isLoading, setIsLoading] = useState(false); // true = waiting for first token
  const [showDocs, setShowDocs] = useState(false);
  const [quotaRefreshTrigger, setQuotaRefreshTrigger] = useState(0);
  const [pushedQuota, setPushedQuota] = useState(null);
  const messagesEndRef = useRef(null);
  const textareaRef = useRef(null);
  const abortControllerRef = useRef(null);
  const fileInputRef = useRef(null);

  // ── File upload state ─────────────────────────────────────────────────────
  const [attachedFile, setAttachedFile] = useState(null); // { filename, text, metadata }
  const [isUploading, setIsUploading] = useState(false);
  const [showAttachMenu, setShowAttachMenu] = useState(false);

  // ── Message Actions ────────────────────────────────────────────────────────
  const handleLikeMessage = (idx) => {
    setMessages((prev) =>
      prev.map((msg, i) =>
        i === idx ? { ...msg, liked: true, disliked: false } : msg
      )
    );
  };

  const handleDislikeMessage = (idx) => {
    setMessages((prev) =>
      prev.map((msg, i) =>
        i === idx ? { ...msg, liked: false, disliked: true } : msg
      )
    );
  };

  const handleCopyMessage = (text) => {
    navigator.clipboard.writeText(text);
    // Could add a small toast notification here
  };

  // ── Client-side message guard ──────────────────────────────────────────────
  const { guardCheck, registerSend } = useMessageGuard();
  const [guardResult, setGuardResult] = useState(null);
  const [pendingMessage, setPendingMessage] = useState(null);

  // ── Intent definitions ────────────────────────────────────────────────────
  const { intents } = useIntent();
  const INTENTS = mapIntents(intents);
  const INTENT_OPTIONS = [AUTO_INTENT_OPTION, ...INTENTS];
  // ── Sensitivity levels ───────────────────────────────────────────────────
  const SENSITIVITY_LEVELS = [
    { value: "LOW", label: "🟢 Low", color: "#4ade80" },
    { value: "MEDIUM", label: "🟡 Medium", color: "#facc15" },
    { value: "HIGH", label: "🔴 High", color: "#f87171" },
  ];

  const [selectedIntent, setSelectedIntent] = useState("");

  // Update selectedIntent when INTENTS are loaded
  useEffect(() => {
    if (INTENT_OPTIONS.length > 0 && !selectedIntent) {
      setSelectedIntent(INTENT_OPTIONS[0].value);
    }
  }, [INTENT_OPTIONS, selectedIntent, intents]);
  const [selectedSensitivity, setSelectedSensitivity] = useState("LOW");
  const [resolvedService, setResolvedService] = useState(null);

  // ── Auto-scroll ───────────────────────────────────────────────────────────
  const scrollToBottom = () =>
    messagesEndRef.current?.scrollIntoView({ behavior: "smooth" });

  useEffect(() => {
    scrollToBottom();
  }, [messages, isLoading]);

  useEffect(() => {
    if (textareaRef.current) {
      textareaRef.current.style.height = "auto";
      textareaRef.current.style.height = `${textareaRef.current.scrollHeight}px`;
    }
  }, [input]);

  useEffect(() => {
    if (documents?.length > 0) setShowDocs(true);
  }, [documents]);

  // ── Guard handlers ─────────────────────────────────────────────────────────
  const handleGuardConfirm = useCallback(() => {
    setGuardResult(null);
    if (pendingMessage) {
      registerSend();
      _doSend(pendingMessage);
      setPendingMessage(null);
    }
  }, [pendingMessage]);

  const handleGuardCancel = useCallback(() => {
    setGuardResult(null);
    setPendingMessage(null);
  }, []);

  // ── File upload handler ────────────────────────────────────────────────────
  const handleFileUpload = async (e) => {
    const file = e.target.files?.[0];
    if (!file) return;

    setIsUploading(true);
    try {
      const formData = new FormData();
      formData.append("file", file);

      const res = await fetch(`${API_BASE}/ai/upload-file`, {
        method: "POST",
        headers: {
          Authorization: `Bearer ${token}`,
        },
        body: formData,
      });

      if (!res.ok) {
        const err = await res.json().catch(() => ({}));
        alert(`File upload failed: ${err.detail || "Unknown error"}`);
        return;
      }

      const data = await res.json();
      setAttachedFile({
        filename: data.filename,
        text: data.extracted_text,
        metadata: data.metadata,
      });
    } catch (err) {
      console.error("File upload error:", err);
      alert("Failed to upload file. Please try again.");
    } finally {
      setIsUploading(false);
      // Reset file input so the same file can be re-selected
      if (fileInputRef.current) fileInputRef.current.value = "";
    }
  };

  // ── Send handler (SSE streaming via native fetch) ─────────────────────────
  const handleSend = async (e) => {
    if (e) e.preventDefault();
    if (!input.trim() || isLoading) return;

    // ── Client-side pre-flight guard ─────────────────────────────
    const result = guardCheck(input);
    if (result.blocked) {
      setGuardResult(result);
      return; // hard block — do not send
    }
    if (result.warn) {
      setPendingMessage(input.trim());
      setGuardResult(result);
      return; // soft warn — wait for user confirmation
    }
    registerSend();
    _doSend(input.trim());
  };

  const _doSend = async (messageText) => {
    if (!messageText || isLoading) return;

    const MAX_HISTORY = 6;
    // Sliding window — prevents context overflow and avoids
    // re-scanning old PII in backend content inspector

    // If a file is attached, prepend its content as context
    let fullContent = messageText;
    if (attachedFile) {
      fullContent = `[Attached File: ${attachedFile.filename}]\n\n${attachedFile.text}\n\n---\n\nUser Question: ${messageText}`;
    }

    const userMessage = {
      role: "user",
      content: fullContent,
      displayContent: messageText, // original text for display
      attachedFilename: attachedFile?.filename || null,
      timestamp: new Date().toLocaleTimeString([], {
        hour: "2-digit",
        minute: "2-digit",
      }),
      providedSensitivity: selectedSensitivity,
    };

    const conversationHistory = [...messages, userMessage].slice(-MAX_HISTORY);

    setMessages((prev) => [...prev, userMessage]);
    setInput("");
    setAttachedFile(null); // Clear attachment after sending
    setIsLoading(true);

    const controller = new AbortController();
    abortControllerRef.current = controller;

    try {
      const response = await fetch(`${API_BASE}/ai/request`, {
        signal: controller.signal,
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
          Accept: "text/event-stream",
        },
        body: JSON.stringify({
          intent: selectedIntent || AUTO_INTENT_OPTION.value,
          payload: {
            messages: conversationHistory.map((m) => ({
              role: m.role,
              content: m.content,
            })),
          },
          metadata: {
            sensitivity: selectedSensitivity,
            environment: "dev",
          },
        }),
      });

      // ── Pre-stream error (auth failure, 422, 403) ─────────────────────
      if (!response.ok) {
        const errData = await response.json().catch(() => ({}));
        const parsed = parseChatError({
          status: response.status,
          detail: errData.detail,
        });
        setMessages((prev) =>
          applyChatErrorToMessages(prev, {
            ...parsed,
            selectedSensitivity,
          }),
        );
        return;
      }

      // ── Stream reading ────────────────────────────────────────────────
      const reader = response.body.getReader();
      const decoder = new TextDecoder();
      let buffer = "";
      let placeholderAdded = false;

      const addPlaceholder = () => {
        if (placeholderAdded) return;
        placeholderAdded = true;
        setIsLoading(false); // hide typing dots
        setMessages((prev) => [
          ...prev,
          {
            role: "assistant",
            content: "",
            timestamp: new Date().toLocaleTimeString([], {
              hour: "2-digit",
              minute: "2-digit",
            }),
            isStreaming: true,
            providedSensitivity: selectedSensitivity,
          },
        ]);
      };

      // eslint-disable-next-line no-constant-condition
      while (true) {
        const { done, value } = await reader.read();
        if (done) break;

        buffer += decoder.decode(value, { stream: true });

        // SSE events are separated by \n\n
        const events = buffer.split("\n\n");
        buffer = events.pop(); // keep any incomplete trailing event

        for (const event of events) {
          const dataLine = event
            .split("\n")
            .find((l) => l.startsWith("data: "));
          if (!dataLine) continue;

          let data;
          try {
            data = JSON.parse(dataLine.slice(6));
          } catch {
            continue;
          }

          if (data.status === "thinking") {
            addPlaceholder();
            continue;
          }

          // ── Error event from server (pre-flight SSE or mid-stream) ───
          if (data.error) {
            const parsed = parseSseChatError(data.error);
            if (placeholderAdded) {
              setMessages((prev) => {
                const updated = [...prev];
                updated[updated.length - 1] = {
                  ...updated[updated.length - 1],
                  content: parsed.errMsg,
                  isStreaming: false,
                  isError: true,
                  detectedPiiTypes: parsed.detectedPiiTypes,
                  piiCount: parsed.piiCount,
                };
                return updated;
              });
            } else {
              setMessages((prev) =>
                applyChatErrorToMessages(prev, {
                  ...parsed,
                  selectedSensitivity,
                }),
              );
            }
            return;
          }

          // ── First token: inject the placeholder bubble ───────────────
          if (!placeholderAdded && data.token !== undefined) {
            addPlaceholder();
          }

          // ── Append token to the last message ────────────────────────
          if (shouldAppendToken(data)) {
            setMessages((prev) => {
              const updated = [...prev];
              updated[updated.length - 1] = {
                ...updated[updated.length - 1],
                content: updated[updated.length - 1].content + data.token,
              };
              return updated;
            });
          }

          // ── Final event: seal the message ────────────────────────────
          if (data.done) {
            setQuotaRefreshTrigger((prev) => prev + 1);
            if (data.quota) setPushedQuota(data.quota);
            if (data.resolved_service)
              setResolvedService(data.resolved_service);
            setMessages((prev) => {
              const updated = [...prev];
              const lastIdx = updated.length - 1;
              const piiMeta = {
                resolvedSensitivity: data.resolved_sensitivity || null,
                detectedPiiTypes: Array.isArray(data.detected_pii_types)
                  ? data.detected_pii_types
                  : null,
                piiCount: data.pii_count || 0,
              };

              updated[lastIdx] = {
                ...updated[lastIdx],
                isStreaming: false,
                requestId: data.request_id || null,
                resolvedService: data.resolved_service || null,
                resolvedIntent: data.intent || null,
                providedIntent: data.provided_intent || null,
                intentMode: data.intent_mode || null,
                intentSource: data.intent_source || null,
                intentTaxonomyVersion: data.intent_taxonomy_version || null,
                intentConfidence:
                  typeof data.intent_confidence === "number"
                    ? data.intent_confidence
                    : null,
                providedSensitivity: selectedSensitivity,
                ...piiMeta,
                metrics: {
                  proxyLatency: response.headers.get("x-kong-proxy-latency"),
                  upstreamLatency: response.headers.get(
                    "x-kong-upstream-latency",
                  ),
                  debug: response.headers.get("x-ai-debug"),
                },
              };

              // Mirror PII / resolved sensitivity onto the user turn for bubble tinting
              if (lastIdx > 0 && updated[lastIdx - 1]?.role === "user") {
                updated[lastIdx - 1] = {
                  ...updated[lastIdx - 1],
                  ...piiMeta,
                };
              }

              return updated;
            });
          }
        }
      }
    } catch (err) {
      if (err.name === "AbortError") {
        setMessages((prev) => {
          const updated = [...prev];
          const last = updated[updated.length - 1];
          if (last?.role === "assistant" && last?.isStreaming) {
            updated[updated.length - 1] = {
              ...last,
              isStreaming: false,
              isCancelled: true,
            };
          } else {
            updated.push({
              role: "assistant",
              content: "",
              timestamp: new Date().toLocaleTimeString([], {
                hour: "2-digit",
                minute: "2-digit",
              }),
              isCancelled: true,
            });
          }
          return updated;
        });
      } else {
        console.error("AI Chat Error:", err);
        setMessages((prev) => [
          ...prev,
          {
            role: "assistant",
            content: "Sorry, I'm having trouble connecting to the AI service.",
            timestamp: new Date().toLocaleTimeString([], {
              hour: "2-digit",
              minute: "2-digit",
            }),
            isError: true,
          },
        ]);
      }
    } finally {
      abortControllerRef.current = null;
      setIsLoading(false);
    }
  };

  const handleCancel = () => {
    if (abortControllerRef.current) {
      abortControllerRef.current.abort();
    }
  };

  const handleKeyDown = (e) => {
    if (e.key === "Enter" && !e.shiftKey) {
      e.preventDefault();
      handleSend();
    }
  };

  const isActive = isLoading || messages.some((m) => m.isStreaming);
  const selectedIntentLabel =
    INTENT_OPTIONS.find((i) => i.value === selectedIntent)?.label ?? selectedIntent;

  return (<>
    <div className="chat-layout">
      {/* ── Sidebar ──────────────────────────────────────────────────────── */}
      <div className="chat-sidebar">
        <div className="sidebar-header">
          <div className="sidebar-logo">Nextora AI</div>
        </div>

        <div className="sidebar-section-title">Tools</div>
        <div className="sidebar-tools">
          <div 
            className={`sidebar-tool ${activeTool === "chat" ? "active" : ""}`}
            onClick={() => setActiveTool("chat")}
          >
            <div className="tool-left">💬 AI Chat</div>
          </div>
          
          <div 
            className={`sidebar-tool ${activeTool === "library" ? "active" : ""}`}
            onClick={() => {
              setActiveTool("library");
              // Currently just opens the API directly or we can load it in the UI later
              // For now we just select it
            }}
          >
            <div className="tool-left">📚 Prompt Library</div>
          </div>

          <div 
            className={`sidebar-tool ${activeTool === "ide" ? "active" : ""}`}
            onClick={() => setActiveTool("ide")}
          >
            <div className="tool-left">&lt;/&gt; Agent IDE</div>
            <span className="tool-lock">🔒</span>
          </div>

          <div 
            className={`sidebar-tool ${activeTool === "shell" ? "active" : ""}`}
            onClick={() => setActiveTool("shell")}
          >
            <div className="tool-left">🐚 Code Shell</div>
            <span className="tool-lock">🔒</span>
          </div>
        </div>

        {/* Show chat history ONLY if chat is active */}
        {activeTool === "chat" && (
          <div className="sidebar-chat-history">
            <div className="sidebar-section-title" style={{ marginTop: 0 }}>History</div>
            <button className="new-chat-btn" onClick={createNewChat}>
              + New Chat
            </button>
            <div className="chat-list">
              {chats.map((c) => (
                <div
                  key={c.id}
                  className={`chat-list-item ${c.id === currentChatId ? "active" : ""}`}
                  onClick={() => selectChat(c.id)}
                >
                  <span style={{ overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>
                    {c.title}
                  </span>
                  <button
                    className="delete-chat-btn"
                    onClick={(e) => {
                      e.stopPropagation();
                      deleteChat(c.id);
                    }}
                    title="Delete Chat"
                  >
                    ✕
                  </button>
                </div>
              ))}
            </div>
          </div>
        )}
      </div>

      <div className="main-content-area">
        {/* ── Locked Tool Overlays ─────────────────────────────────────── */}
        {(activeTool === "ide" || activeTool === "shell") && (
          <div className="tool-locked-overlay">
            <h2>🔒 Premium Feature</h2>
            <p>
              {activeTool === "ide" 
                ? "The Agent IDE provides a full Monaco-powered code editor with autonomous AI code generation directly in the browser."
                : "The Code Shell provides an isolated terminal emulator to execute and test AI-generated code securely."}
            </p>
            <button className="upgrade-btn">Upgrade to Unlock</button>
          </div>
        )}
        
        {/* ── Prompt Library UI ─────────────────────────────────────── */}
        {activeTool === "library" && (
          <div className="library-container">
            <div className="library-header">
              <h2>Prompt Library</h2>
              <p>Curated AI templates to supercharge your workflow.</p>
            </div>
            
            {loading ? (
              <div style={{ color: "var(--text-dim)" }}>Loading prompts...</div>
            ) : error ? (
              <div style={{ color: "#ef4444" }}>{error}</div>
            ) : (
              <div className="library-grid">
                {documents.map((doc, idx) => (
                  <div key={idx} className="prompt-card">
                    <div className="prompt-card-header">
                      <div className="prompt-icon">{doc.metadata?.icon || "📄"}</div>
                      <div className="prompt-title-area">
                        <h3>{doc.title}</h3>
                        <div className="prompt-category">{doc.category}</div>
                      </div>
                    </div>
                    
                    <p className="prompt-desc">{doc.metadata?.description || "No description available."}</p>
                    
                    {doc.metadata?.tags && (
                      <div className="prompt-tags">
                        {doc.metadata.tags.map(tag => (
                          <span key={tag} className="prompt-tag">#{tag}</span>
                        ))}
                      </div>
                    )}
                    
                    <button 
                      className="use-prompt-btn"
                      onClick={() => {
                        setInput(doc.prompt);
                        setActiveTool("chat");
                        if (textareaRef.current) {
                          textareaRef.current.focus();
                        }
                      }}
                    >
                      Use Prompt
                    </button>
                  </div>
                ))}
              </div>
            )}
          </div>
        )}

      <div className="chat-window" style={{ 
        display: activeTool === "library" ? "none" : "flex",
        filter: (activeTool === "ide" || activeTool === "shell") ? "blur(4px)" : "none", 
        transition: "filter 0.3s" 
      }}>
      {/* Inject blinking cursor styles once */}
      <style>{CURSOR_STYLE}</style>

      {/* ── Header ───────────────────────────────────────────────────────── */}
      <div className="chat-header">
        <div style={{ display: "flex", alignItems: "center", gap: "1rem" }}>
          <div className="avatar ai">AI</div>
          <div>
            <h3
              style={{
                fontSize: "1rem",
                fontWeight: 600,
                display: "flex",
                alignItems: "center",
                gap: "0.5rem",
              }}
            >
              {selectedIntentLabel}
              {resolvedService && (
                <span
                  style={{
                    fontSize: "0.65rem",
                    fontWeight: 500,
                    padding: "2px 8px",
                    borderRadius: "999px",
                    background: "var(--glass-border)",
                    border: "1px solid var(--glass-border)",
                    color: "var(--text-dim)",
                    letterSpacing: "0.02em",
                  }}
                >
                  {resolvedService}
                </span>
              )}
            </h3>
            <span style={{ fontSize: "0.75rem", color: "var(--text-dim)" }}>
              Intent-based AI Routing
            </span>
          </div>
        </div>

        <div style={{ display: "flex", gap: "1.5rem", alignItems: "center" }}>
        <QuotaStatus 
            token={token} 
            trigger={quotaRefreshTrigger} 
            pushedData={pushedQuota}
          />
          <div style={{ display: "flex", gap: "0.8rem", alignItems: "center" }}>
          <button
            onClick={() => setIsDarkMode(!isDarkMode)}
            style={{
              background: "rgba(128, 128, 128, 0.2)",
              border: "1px solid var(--glass-border)",
              color: isDarkMode ? "#fbbf24" : "#4f46e5",
              cursor: "pointer",
              fontSize: "1.2rem",
              padding: "0.3rem 0.5rem",
              borderRadius: "8px",
              display: "flex",
              alignItems: "center",
              justifyContent: "center",
            }}
            title={isDarkMode ? "Switch to Light Mode" : "Switch to Dark Mode"}
          >
            {isDarkMode ? "☀️" : "🌙"}
          </button>
          {isAdmin && (
            <button
              className="dashboard-btn"
              onClick={onOpenAdmin}
              style={{
                borderColor: "var(--accent-primary)",
                background: isDarkMode ? "rgba(59, 130, 246, 0.1)" : "rgba(79, 70, 229, 0.08)",
                fontWeight: 600,
              }}
            >
              Intent Admin
            </button>
          )}
          <button
            className="dashboard-btn"
            onClick={fetchDocuments}
            disabled={loading}
          >
            {loading ? "..." : "Docs"}
          </button>
          <button
            className="dashboard-btn"
            onClick={fetchAdmin}
            disabled={loading}
          >
            {loading ? "..." : "Admin"}
          </button>
          <button
            className="dashboard-btn"
            onClick={logout}
            style={{ borderColor: "rgba(239, 68, 68, 0.3)", color: "#f87171" }}
          >
            Logout
          </button>
        </div>
        </div>
      </div>

      {/* ── Messages ─────────────────────────────────────────────────────── */}
      <div className="chat-messages-container">
        {error && (
          <div className="message-wrapper ai" style={{ alignSelf: "center" }}>
            <div
              className="message-bubble"
              style={{
                borderColor: "rgba(239, 68, 68, 0.4)",
                color: "#fca5a5",
              }}
            >
              System Alert: {error}
            </div>
          </div>
        )}

        {showDocs && documents?.length > 0 && (
          <div
            className="message-wrapper ai"
            style={{ alignSelf: "center", width: "100%", maxWidth: "900px" }}
          >
            <div
              className="message-bubble"
              style={{ width: "100%", background: "var(--bg-deep)" }}
            >
              <div
                style={{
                  display: "flex",
                  justifyContent: "space-between",
                  marginBottom: "1rem",
                }}
              >
                <h4 style={{ color: "var(--accent-primary)" }}>
                  Fetched Resources
                </h4>
                <button
                  onClick={() => setShowDocs(false)}
                  style={{
                    background: "none",
                    border: "none",
                    color: "var(--text-dim)",
                    cursor: "pointer",
                  }}
                >
                  ✕
                </button>
              </div>
              <ul
                style={{
                  listStyle: "none",
                  display: "grid",
                  gridTemplateColumns: "repeat(auto-fill, minmax(200px, 1fr))",
                  gap: "0.5rem",
                }}
              >
                {documents.map((doc) => (
                  <li
                    key={doc.id}
                    style={{
                      padding: "0.5rem",
                      background: "var(--bg-card)",
                      borderRadius: "8px",
                      fontSize: "0.85rem",
                      border: "1px solid var(--glass-border)",
                      color: "var(--text-main)",
                    }}
                  >
                    ▹ {doc.name}
                  </li>
                ))}
              </ul>
            </div>
          </div>
        )}

        {messages.map((m, i) => {
          const level = m.resolvedSensitivity
            ? getSensitivityTheme(m.resolvedSensitivity)
            : null;
          const isSensitivityMatch =
            m.resolvedSensitivity &&
            m.providedSensitivity &&
            m.resolvedSensitivity === m.providedSensitivity;
          const isSensitivityUpgraded =
            m.resolvedSensitivity &&
            m.providedSensitivity &&
            m.resolvedSensitivity !== m.providedSensitivity;
          const showSensitivityTint = isSensitivityUpgraded && level != null;

          return (
          <div
            key={i}
            className={`message-wrapper ${m.role} ${m.isError ? "error" : ""}`}
          >
            <div className={`avatar ${m.role === "user" ? "user" : "ai"}`}>
              {m.role === "user" ? "ME" : "AI"}
            </div>
            <div
              style={{
                display: "flex",
                flexDirection: "column",
                width: "100%",
              }}
            >
              <div
                className={`message-bubble ${m.isCancelled ? "cancelled-bubble" : ""}`}
                style={
                  showSensitivityTint
                    ? {
                        boxShadow: `0 0 0 2px ${level.border}`,
                        ...(m.role === "user"
                          ? {}
                          : { background: level.softBg }),
                      }
                    : undefined
                }
              >
                {m.isCancelled ? (
                  <div className="cancelled-message">
                    {m.content && (
                      <span style={{ whiteSpace: "pre-wrap", display: "block", marginBottom: "0.5rem" }}>
                        {m.content}
                      </span>
                    )}
                    <span className="cancelled-label">User cancelled response</span>
                  </div>
                ) : (
                  <>
                    {m.isStreaming ? (
                      <span style={{ whiteSpace: "pre-wrap" }}>{m.content}</span>
                    ) : (
                      <div className="chat-markdown">
                        <ReactMarkdown remarkPlugins={[remarkGfm]}>
                          {m.content}
                        </ReactMarkdown>
                      </div>
                    )}
                    {m.isStreaming && (
                      <span className="ai-cursor" aria-hidden="true" />
                    )}
                  </>
                )}

                {/* Kong Metrics */}
                {m.metrics && (
                  <div
                    style={{
                      marginTop: "0.8rem",
                      paddingTop: "0.8rem",
                      borderTop: "1px solid rgba(255,255,255,0.1)",
                      display: "flex",
                      flexWrap: "wrap",
                      gap: "1rem",
                      fontSize: "0.75rem",
                      color: "var(--text-dim)",
                    }}
                  >
                    <div title="Full Kong path latency">
                      ⏱{" "}
                      <span style={{ color: "var(--accent-primary)" }}>
                        {m.metrics.proxyLatency}ms
                      </span>{" "}
                      Proxy
                    </div>
                    <div title="Target (Ollama) latency">
                      🚀{" "}
                      <span style={{ color: "var(--accent-primary)" }}>
                        {m.metrics.upstreamLatency}ms
                      </span>{" "}
                      Upstream
                    </div>
                    {m.metrics.debug && (
                      <div style={{ fontStyle: "italic", opacity: 0.8 }}>
                        ⚙ {m.metrics.debug}
                      </div>
                    )}
                  </div>
                )}

                {/* PII indicator (server-side inspection summary) */}
                {Array.isArray(m.detectedPiiTypes) &&
                  m.detectedPiiTypes.length > 0 &&
                  level && (
                    <div
                      style={{
                        marginTop: "1rem",
                        padding: "0.75rem 1rem",
                        background: isSensitivityMatch
                          ? "transparent"
                          : level.softBg,
                        border: isSensitivityMatch
                          ? "1px solid rgba(255,255,255,0.1)"
                          : `1px solid ${level.border}`,
                        borderRadius: "12px",
                        fontSize: "0.8rem",
                        color: isSensitivityMatch ? "inherit" : level.text,
                        display: "flex",
                        flexDirection: "column",
                        gap: "0.4rem",
                        boxShadow: "0 4px 6px -1px rgba(0, 0, 0, 0.1), 0 2px 4px -1px rgba(0, 0, 0, 0.06)",
                        backdropFilter: "blur(4px)",
                        maxWidth: "100%",
                      }}
                      title="Server-side PII Detection Summary"
                    >
                      <div style={{ display: "flex", alignItems: "center", gap: "0.5rem" }}>
                        <span style={{ 
                          background: level.bg, 
                          color: "white", 
                          padding: "2px 8px", 
                          borderRadius: "999px", 
                          fontWeight: 700,
                          fontSize: "0.7rem",
                          letterSpacing: "0.02em",
                          whiteSpace: "nowrap"
                        }}>
                          {m.piiCount || m.detectedPiiTypes.length} DETECTED
                        </span>
                        <span style={{ fontWeight: 600, fontSize: "0.85rem" }}>PII Scan Result</span>
                      </div>
                      <div style={{ display: "flex", flexWrap: "wrap", gap: "0.4rem" }}>
                        {m.detectedPiiTypes.map(type => (
                          <span key={type} style={{
                            background: level.softBg,
                            padding: "1px 6px",
                            borderRadius: "4px",
                            fontSize: "0.7rem",
                            border: `1px solid ${level.border}`
                          }}>
                            {type}
                          </span>
                        ))}
                      </div>
                      {m.resolvedSensitivity && (
                        <div style={{ 
                          marginTop: "0.2rem", 
                          fontSize: "0.7rem", 
                          opacity: 0.8,
                          borderTop: `1px solid ${level.border}`,
                          paddingTop: "0.4rem"
                        }}>
                          Resolved Sensitivity:{" "}
                          <span style={{ fontWeight: 700, color: level.text }}>
                            {m.resolvedSensitivity}
                          </span>
                          {m.providedSensitivity && !isSensitivityMatch && (
                            <span style={{ opacity: 0.75 }}>
                              {" "}
                              (declared {m.providedSensitivity})
                            </span>
                          )}
                        </div>
                      )}
                    </div>
                  )}

                {isSensitivityUpgraded &&
                  level &&
                  (!m.detectedPiiTypes || m.detectedPiiTypes.length === 0) && (
                    <div
                      style={{
                        marginTop: "0.75rem",
                        padding: "0.5rem 0.75rem",
                        background: level.softBg,
                        border: `1px solid ${level.border}`,
                        borderRadius: "10px",
                        fontSize: "0.75rem",
                        color: level.text,
                      }}
                    >
                      Sensitivity upgraded: {m.providedSensitivity} →{" "}
                      {m.resolvedSensitivity}
                    </div>
                  )}
              </div>
              
              {/* Message Actions (Like, Dislike, Copy) */}
              {m.role === "assistant" && !m.isStreaming && !m.isCancelled && (
                <div className="message-action-bar">
                  <button 
                    className={`msg-action-btn ${m.liked ? "active" : ""}`}
                    onClick={() => handleLikeMessage(i)}
                    title="Like this response"
                  >
                    {m.liked ? "👍" : "🤍"}
                  </button>
                  <button 
                    className={`msg-action-btn ${m.disliked ? "active" : ""}`}
                    onClick={() => handleDislikeMessage(i)}
                    title="Dislike this response"
                  >
                    {m.disliked ? "👎" : "👎🏻"}
                  </button>
                  <button 
                    className="msg-action-btn"
                    onClick={() => handleCopyMessage(m.content)}
                    title="Copy to clipboard"
                  >
                    📋
                  </button>
                </div>
              )}

              {/* Request ID below AI bubble */}
              {m.role === "assistant" && m.requestId && (
                <div
                  style={{
                    marginTop: "0.25rem",
                    fontSize: "0.7rem",
                    color: "var(--text-dim)",
                    opacity: 0.6,
                    paddingLeft: "0.2rem",
                  }}
                >
                  Request ID: {m.requestId.slice(0, 8)}-…
                </div>
              )}
              {m.role === "assistant" && hasIntentClassificationDetails(m) && (
                <div className="intent-classifier-bubble">
                  {m.resolvedIntent && (
                    <span className="intent-classifier-chip">
                      intent: {m.resolvedIntent}
                    </span>
                  )}
                  {m.intentMode && (
                    <span className="intent-classifier-chip">mode: {m.intentMode}</span>
                  )}
                  {m.intentSource && (
                    <span className="intent-classifier-chip">
                      source: {m.intentSource}
                    </span>
                  )}
                  {formatIntentConfidence(m.intentConfidence) && (
                    <span className="intent-classifier-chip">
                      confidence: {formatIntentConfidence(m.intentConfidence)}
                    </span>
                  )}
                  {m.intentTaxonomyVersion && (
                    <span className="intent-classifier-chip">
                      taxonomy: {m.intentTaxonomyVersion}
                    </span>
                  )}
                </div>
              )}

              <div className="timestamp">{m.timestamp}</div>
            </div>
          </div>
        );
        })}

        {/* Typing dots — while waiting for first token */}
        {isLoading && (
          <div className="message-wrapper ai">
            <div className="avatar ai">AI</div>
            <div className="message-bubble" style={{ padding: "0.5rem 1rem" }}>
              <div className="typing-dots">
                <div className="dot"></div>
                <div className="dot"></div>
                <div className="dot"></div>
              </div>
            </div>
          </div>
        )}
        <div ref={messagesEndRef} />
      </div>

      {/* ── Input bar ────────────────────────────────────────────────────── */}
      <div className="input-section">
        {/* File attachment indicator */}
        {attachedFile && (
          <div className="attached-file-chip">
            <span>📎 {attachedFile.filename}</span>
            <span style={{ fontSize: "0.7rem", color: "var(--text-dim)" }}>
              ({(attachedFile.metadata?.extracted_chars || 0).toLocaleString()} chars)
            </span>
            <button
              className="remove-file-btn"
              onClick={() => setAttachedFile(null)}
              title="Remove attachment"
            >✕</button>
          </div>
        )}
        {isUploading && (
          <div className="attached-file-chip" style={{ opacity: 0.7 }}>
            <span>⏳ Uploading and extracting text...</span>
          </div>
        )}
        <div className="input-container-pill">
          {/* Hidden file inputs */}
          <input
            ref={fileInputRef}
            type="file"
            accept=".pdf,.txt,.csv,.md,.json,.log,.py,.js,.ts,.yaml,.yml"
            onChange={handleFileUpload}
            style={{ display: "none" }}
          />
          <input
            id="photoInput"
            type="file"
            accept=".jpg,.jpeg,.png,.webp,.gif"
            onChange={handleFileUpload}
            style={{ display: "none" }}
          />

          {/* Plus / attach button with menu */}
          <div className="attach-menu-container">
            <button
              className={`attach-file-btn ${showAttachMenu ? "active" : ""}`}
              onClick={() => setShowAttachMenu(!showAttachMenu)}
              disabled={isUploading || isActive}
              title="Attach a file or photo"
            >
              <svg viewBox="0 0 24 24" width="20" height="20" fill="none" stroke="currentColor" strokeWidth="2.5" strokeLinecap="round" strokeLinejoin="round">
                <line x1="12" y1="5" x2="12" y2="19" />
                <line x1="5" y1="12" x2="19" y2="12" />
              </svg>
            </button>
            
            {showAttachMenu && (
              <div className="attach-dropdown-menu">
                <button 
                  className="attach-dropdown-item"
                  onClick={() => {
                    setShowAttachMenu(false);
                    fileInputRef.current?.click();
                  }}
                >
                  📄 Document
                </button>
                <button 
                  className="attach-dropdown-item"
                  onClick={() => {
                    setShowAttachMenu(false);
                    document.getElementById("photoInput")?.click();
                  }}
                >
                  🖼️ Photo
                </button>
              </div>
            )}
          </div>

          <textarea
            ref={textareaRef}
            className="type-area"
            placeholder={attachedFile ? `Ask about ${attachedFile.filename}...` : "Ask anything or attach a file..."}
            rows="1"
            value={input}
            onChange={(e) => setInput(e.target.value)}
            onKeyDown={handleKeyDown}
            disabled={isActive}
          />
          <div className="input-actions-group">
            {/* Sensitivity selector */}
            <select
              className="model-select-dropdown"
              value={selectedSensitivity}
              onChange={(e) => setSelectedSensitivity(e.target.value)}
              disabled={isActive}
              title="Declare payload sensitivity"
              style={{
                borderColor:
                  selectedSensitivity === "HIGH"
                    ? "rgba(248, 113, 113, 0.5)"
                    : selectedSensitivity === "MEDIUM"
                      ? "rgba(250, 204, 21, 0.5)"
                      : "rgba(74, 222, 128, 0.4)",
                color:
                  selectedSensitivity === "HIGH"
                    ? "#f87171"
                    : selectedSensitivity === "MEDIUM"
                      ? "#facc15"
                      : "#4ade80",
              }}
            >
              {SENSITIVITY_LEVELS.map((s) => (
                <option key={s.value} value={s.value}>
                  {s.label}
                </option>
              ))}
            </select>

            {/* Intent selector */}
            <select
              className="model-select-dropdown"
              value={selectedIntent || ""}
              onChange={(e) => {
                setSelectedIntent(e.target.value);
                setResolvedService(null);
              }}
              disabled={isActive}
            >
              {INTENT_OPTIONS ? (
                INTENT_OPTIONS.filter((intent) => intent.value !== "unclassified").map((intent) => (
                  <option key={intent.value} value={intent.value}>
                    {intent.label}
                  </option>
                ))
              ) : (
                <option>Loading intents...</option>
              )}
            </select>
            {isActive ? (
              <button
                className="send-btn-pill stop-btn"
                onClick={handleCancel}
                title="Cancel response"
              >
                <svg viewBox="0 0 24 24" width="16" height="16" fill="currentColor">
                  <rect x="4" y="4" width="16" height="16" rx="2" />
                </svg>
              </button>
            ) : (
              <button
                className="send-btn-pill"
                onClick={handleSend}
                disabled={!input.trim()}
              >
                <svg
                  viewBox="0 0 24 24"
                  width="20"
                  height="20"
                  fill="currentColor"
                >
                  <path d="M2.01 21L23 12 2.01 3 2 10l15 2-15 2z" />
                </svg>
              </button>
            )}
          </div>
        </div>
      </div>
      </div>
    </div>
    </div>

    {/* ── Client-side Security Guard Modal ──────────────────────────── */}
    <MessageGuardModal
      guardResult={guardResult}
      onConfirm={handleGuardConfirm}
      onCancel={handleGuardCancel}
    />
  </>);
};

export default AIChat;
