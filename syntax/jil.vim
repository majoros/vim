
syntax keyword  JobTypes    BOX      CMD    DBMON   DBPROC  DBTRIG
syntax keyword  JobTypes    ENTYBEAN FT     FTP     HTTP    I5
syntax keyword  JobTypes    JAVARMI  JMSPUB JMSSUB  JMXMAG  JMXMAS
syntax keyword  JobTypes    JMXMC    JMXMOP JMXMREM JMXSUB  OACOPY
syntax keyword  JobTypes    OASET    OASG   OMCPU   OMD     OMEL
syntax keyword  JobTypes    OMIP     OMP    OMS     OMTF    POJO
syntax keyword  JobTypes    PS       SAPBDC SAPBWIP SAPBWPC SAPDA
syntax keyword  JobTypes    SAPEVT   SAPJC  SAPPM   SAP     SCP
syntax keyword  JobTypes    SESSBEAN SQL    WBSVC   ZOS     ZOSDST
syntax keyword  JobTypes    ZOSM     c      f       b
syntax keyword  ExternTypes a c u e

syntax keyword  Conditions  success    falure terminated s f
syntax keyword  Conditions  terminated done   notrunning exitcode

syntax keyword  Operators   NOT ! ^ AND & OR |

syntax match    Error      /\w*\s*:/
syntax match    Attribute  /\w*:/me=e-1
syntax match    Number     /\s[0-9]*/

syntax match    Delimiters  /[\^\:]/
syntax match    JilComment /#.*$/

syntax match    Parens     /[)(]/

syntax region Comment start=/\v\/\*/ skip=/\v\\./ end=/\v\*\//
syntax region String  start=/\v"/ skip=/\v\\./ end=/\v"/
syntax region String  start=/\v'/ skip=/\v\\./ end=/\v'/

let b:current_syntax = "jil"

hi link Attribute   Keyword
hi link JilComment  Comment
hi link Delimiters  Delimiter
hi link Parens      Special
hi link Operators   Constant
hi link Conditions  Function
hi link JobTypes    Constant
hi link ExternTypes Constant

