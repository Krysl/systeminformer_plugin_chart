default:
  @just --choose

about:
    @awk '/^#/ {print} !/^#/ {exit}' "{{justfile()}}"
    @echo 'Summarises the purpose of this file.'
    @echo 'This lists the comment lines of the file until the first line that does not start with a '#' character. Then it lists the targets of the file.'
    @just --list

alias c:= codegen
alias c2:= codegen2
alias c2d:= codegen2d
alias b:= build
alias b2:= build_release
alias u:= update_lib
alias k:= killSystemInformer
alias r:= run

alias br:= build_runner
alias brw:= build_runner_watch

build_runner:
  dart run build_runner build --delete-conflicting-outputs

build_runner_watch:
  dart run build_runner watch --delete-conflicting-outputs

codegen:
  dart run pigeon --input pigeons/messages.dart

codegen2:
  dart run ffigen --config ffigen.yaml
codegen2d:
  dart run ffigen --config ffigen.yaml --verbose all > ffigen.log

killSystemInformer:
    powershell.exe ./killSystemInformer.ps1

build:
  just killSystemInformer
  flutter build windows -v --debug

build_release:
  flutter build windows -v

format:
  (\
    cd windows/runner; \
    clang-format.exe -style=file -i -style=file *.cpp *.h\
  )

rsync :="G:/msys64/usr/bin/rsync.exe"

update_lib:
  {{rsync}} -rupEv ../systeminformer/sdk/lib/ sdk/lib/

run:
  start ${SYSTEMINFORMER_GIT_FOLDER}/bin/Debug64/SystemInformer.exe