FORCE_CLEAN=false

while getopts ":f" opt; do
  case ${opt} in
    f )
      FORCE_CLEAN=true
      ;;
    \? )
      echo "Invalid option: -$OPTARG" 1>&2
      exit 1
      ;;
    : )
      echo "Option -$OPTARG requires an argument." 1>&2
      exit 1
      ;;
  esac
done
shift $((OPTIND -1))

if [ "$FORCE_CLEAN" = true ]; then
  echo "FORCE CLEAN PROJECT"
fi

if [[ $(uname -p) == 'arm' ]]; then
  echo "================================================"
  echo "=              Script runing on M1             ="
  echo "================================================"
  echo "================== Clean core =================="
fi
if [[ $(uname -p) != 'arm' ]]; then
  echo "================================================"
  echo "=           Script runing on Intel CPU         ="
  echo "================================================"
  echo "================== Clean core =================="
fi

pod_install() {
  if [ "$FORCE_CLEAN" = true ]; then
    pod deintegrate; rm -rf podfile.lock; pod update
  fi
  if [[ $(uname -p) == 'arm' ]]; then
    arch -x86_64 pod install
  fi
  if [[ $(uname -p) != 'arm' ]]; then
    pod install
  fi
}

flutter clean

if [ "$FORCE_CLEAN" = true ]; then
  rm -rf pubspec.lock

fi


flutter pub get
cd ios
pod_install
cd ..
sh gen_localization.sh
flutter pub run module_generator:generate_asset
flutter pub run build_runner build --delete-conflicting-outputs
