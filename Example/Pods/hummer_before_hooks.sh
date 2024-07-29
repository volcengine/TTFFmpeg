#!/usr/bin/env bash
if [[ ! -z ${PODS_ROOT} ]];then
  export -p > "${PODS_ROOT}/hummer_before_env"
  cat << PEOF | xcrun python3 -
import os
import json
try:
  if os.getenv("PODS_ROOT"):
    with open(os.path.join(os.getenv("PODS_ROOT"),"hummer_before_env.json"),'w') as fd:
      app_path = os.getenv("CODESIGNING_FOLDER_PATH")
      info_plist_path = os.getenv("INFOPLIST_PATH")
      if app_path and info_plist_path:
          info_plist_path = os.path.join(os.path.dirname(app_path), info_plist_path)
          if os.path.exists(info_plist_path):
            os.system("cp \"%s\" \"%s/info.plist\"" % (info_plist_path,os.getenv("PODS_ROOT")))
      fd.write(json.dumps(dict(os.environ)))
except Exception:
  pass
PEOF
fi
