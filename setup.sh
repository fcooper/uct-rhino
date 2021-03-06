#!/bin/sh

# This distribution contains contributions or derivatives under copyright
# as follows:
#
# Copyright (c) 2010, Texas Instruments Incorporated
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# - Redistributions of source code must retain the above copyright notice,
#   this list of conditions and the following disclaimer.
# - Redistributions in binary form must reproduce the above copyright
#   notice, this list of conditions and the following disclaimer in the
#   documentation and/or other materials provided with the distribution.
# - Neither the name of Texas Instruments nor the names of its
#   contributors may be used to endorse or promote products derived
#   from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
# TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
# PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
# LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

echo
echo "--------------------------------------------------------------------------------"
echo "RHINOSDK setup script"
echo "Adapted from TISDK setup script -> www.ti.com"
echo
echo "This script will set up your development host for SDK development."
echo "Parts of this script require administrator priviliges (sudo access)."
echo "--------------------------------------------------------------------------------"

rootdirdefault=$PWD
cwd=`dirname $0`

echo
echo "--------------------------------------------------------------------------------"
echo "Which directory do you want to use as your RHINO_SDK_PATH(if this directory does not exist it will be created)"
read -p "[ $rootdirdefault ] " rdir

if [ ! -n "$rdir" ]; then
    rdir=$rootdirdefault
fi

sed -i "s=export RHINO_SDK_PATH\=.*$=export RHINO_SDK_PATH\=$rdir=g" $cwd/Rules.make

echo "--------------------------------------------------------------------------------"

. $cwd/bin/common.sh

$cwd/bin/setup-host-check.sh
check_status

$cwd/bin/add-to-group.sh
check_status

$cwd/bin/setup-package-install.sh
check_status

$cwd/bin/setup-targetfs-nfs.sh
check_status

$cwd/bin/setup-tftp.sh
check_status

$cwd/bin/setup-minicom.sh
check_status

$cwd/bin/setup-uboot-env.sh
check_status

echo
echo "RHINOSDK setup completed!"
echo "http://www.sdrg.ee.uct.ac.za/"
