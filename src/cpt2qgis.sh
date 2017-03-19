#!/bin/sh
#
#        
#       
#       Copyright 2011 Francisco Hernandez <FJHernandez89@gmail.com>
#       
#       This program is free software; you can redistribute it and/or modify
#       it under the terms of the GNU General Public License as published by
#       the Free Software Foundation; either version 2 of the License, or
#       (at your option) any later version.
#       
#       This program is distributed in the hope that it will be useful,
#       but WITHOUT ANY WARRANTY; without even the implied warranty of
#       MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#       GNU General Public License for more details.
#       
#       You should have received a copy of the GNU General Public License
#       along with this program; if not, write to the Free Software
#       Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
#       MA 02110-1301, USA.
#       
#       

# Grab our current directory and cd into it
CurDir="$( cd "$( dirname "$0" )" && pwd )"
cd $CurDir

# Read Arg

if [ $# != 1 ]
then
  echo " USAGE: cpt2qgis.sh <cptfile>"
  echo " I trust you don't break it too much ;)"
fi

IFile=$1
OFile=$( echo $IFile | sed 's/.cpt/.txt/g' )

echo "# cpt2qgis Generated Color Map Export File" > $OFile
echo "INTERPOLATION:INTERPOLATED" >> $OFile

awk '{ if($1 != "#") print $1 ", " $2", " $3", " $4 ", 255, " $1 "\n" $5", " $6", " $7", " $8 ", 255, " $5}' $IFile \
 | awk '!seen[$0]++' \
 | grep '^-[0-9]*\|^[0-9]' >> $OFile

echo "Done"


