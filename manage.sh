#!/bin/bash
# ============================================================================ #
# Author: Tancredi-Paul Grozav <paul@grozav.info>
# ============================================================================ #
# Clean: rm -f {ro,en}/cv.{aux,log,out,pdf}
# Clean logs: for f in *.log;do >$f;done
# ============================================================================ #
(
# ============================================================================ #
# Variables
# ============================================================================ #
set -x &&
script_dir="$(cd $(dirname ${0}) ; pwd)" &&
# ============================================================================ #





# ============================================================================ #
# Run cmds once connected
# ============================================================================ #
function install-requirements()
{
  # Based on Debian 11.5 minimal container

  # Get list of packages from remote repos
  apt-get update &&

  # Install required packages
  apt-get install -y \
    ` # TexLive compiler - base ` \
    texlive \
    ` # TexLive compiler - extra ` \
    texlive-latex-extra \
    ` # Support for romanian language characters ` \
    texlive-lang-european \
    &&

  # Need to get 305 MB of archives.
  # After this operation, 1039 MB of additional disk space will be used.
  true
}
# ============================================================================ #





# ============================================================================ #
# Compile document
# ============================================================================ #
function compile()
{
  file_name="cv" &&
  for build_path in en ro
  do
    echo "Building in ${script_dir}/${build_path}:" &&
    cd ${script_dir}/${build_path} &&
    # Attempt to generate .pdf (actually generates other files) and exits with
    # error. But that's fine, because we'll recompile
    pdflatex -interaction=nonstopmode ${file_name}.tex 1>/dev/null 2>&1 ;
    # Make the table of contents
    # makeindex ${file_name}.idx
    # Make bibliography
    # bibtex ${file_name}.aux
    # Make .PDF ( cite not working first time )
    # pdflatex ${file_name}.tex
    # Make .PDF
    pdflatex -interaction=nonstopmode ${file_name}.tex
  done &&
  
  echo "This should have generated 2 PDF files:" &&
  ls -l ${script_dir}/*/cv.pdf &&
  true
}
# ============================================================================ #





# ============================================================================ #
# Print help
# ============================================================================ #
function print_help() {
  echo "Call this script using:
  --install-requirements   Install requirements over a minimal Debian.
  --compile                Compile documents.
  --help                   Print this help message.
  anything_else            Print this help message."
}
# ============================================================================ #





# ============================================================================ #
# Case logic
# ============================================================================ #
# If no parameter
if [ ${#} == 0 ]; then
  print_help
fi &&

# Case
if [ ${1} ]; then
  case "${1}" in
    --install-requirements) install-requirements ; exit ${?} ;;
    --compile) compile ; exit ${?} ;;
    --help) print_help ; exit ${?} ;;
    *) print_help ; exit ${?} ;;
    esac
fi
) # > ${0}.log 2>&1
# This script must write nothing to (stdout and err), it runs as a service.
exit 0
# ============================================================================ #

