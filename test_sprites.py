import base64
import zlib
import urllib.request

puml = """@startuml
!include <tupadr3/common>
!include <tupadr3/devicons/redis>
!include <tupadr3/devicons/postgresql>
!include <tupadr3/devicons/python>

rectangle "<$redis>\nRedis" as redis
rectangle "<$postgresql>\nPostgreSQL" as pg
rectangle "<$python>\nFastAPI" as py

redis -> pg
pg -> py
@enduml"""

encoded = base64.urlsafe_b64encode(zlib.compress(puml.encode('utf-8'))).decode('utf-8')
url = f'https://kroki.io/plantuml/svg/{encoded}'
try:
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    response = urllib.request.urlopen(req)
    print('SUCCESS')
except Exception as e:
    print(f'ERROR: {e}')
