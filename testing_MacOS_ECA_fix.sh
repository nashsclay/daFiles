#!/bin/bash
MAIN_FOLDER=~/Library/"Application Support"/Electra
ELECTRAFILE="electra-desktop-setup-1.0.8.exe"
ELECTRAOLD="electra-desktop-setup-1.0.6.exe"
LASTUPDATE=June 02, 2018

#**********************************************************
#FROM WINDOWS
#**********************************************************
echo off
setlocal
:MENU
cls
ECHO ...............................................
ECHO ECA User Support Fix-o-Lot v1.0
ECHO Windows 7, 8, 8.1, 10 ONLY!!
ECHO PRESS 1, 2, 3, 5, OR 6 to select your task, or 6 to EXIT.
ECHO ...............................................
ECHO
ECHO 1 - Replace peers.dat
ECHO 2 - Backup Wallet
ECHO 3 - [DO STEP 2 FIRST!] Assertion Error or Blockchain reinstall also JAVA Error
ECHO 4 - Mnemonic Phrase Not Working Fix.....New Wallet
ECHO 5 - Upgrade from QT wallet
ECHO 6 - Quit Wallets
ECHO 7 - EXIT
ECHO

PS3='Type 1, 2, 3, 4, 5, 6, or 7 then press ENTER: '
options=("Option 1" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"
do
	case $opt in
		"Option 1")
            clear
			echo
			echo -e ECA User Support Fix-o-Lot v1.0
			echo -e Last Updated: May 13, 2018
			echo
			echo Downloading latest peers.dat file
			echo
			curl -OL https://github.com/nashsclay/daFiles/raw/master/peers.dat
			echo
			echo -e Checking for Electra folder, please wait...
			sleep 2
			if [ -d "$MAIN_FOLDER" ];
			   then
				  echo
				  echo Electra folder found
				  echo
				  read -p "Press any key to close your current wallet and continue..."
				  killall -9 Electra-qt >/dev/null 2>&1
				  killall -9 Electrad >/dev/null 2>&1
				  echo
				  echo Copying peers.dat to "$MAIN_FOLDER"
				  yes | cp -rf ./peers.dat "$MAIN_FOLDER"/peers.dat
				  sleep 1
				  echo
				  echo Copying peers.dat complete
				  echo
				  echo Now restart your wallet
				  echo
				  read -p "Press any key to go to the menu"
				  echo
				  clear
				  GOTO 
			   else
				  echo
				  echo Electra folder does not exist in "$MAIN_FOLDER" ...
				  echo
				  read -p "Press any key to quit"
				  echo
				  clear
				  exit 1
			fi

            ;;
        "Option 2")
            echo "you chose choice 2"
            ;;
        "Option 3")
            echo "you chose choice 3"
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done

:WALLET
echo
echo -=ECA User Spport Fix-o-Lot=-
for /f %%x in ('wmic path win32_localtime get /format:list ^| findstr "="') do set %%x
set today=%Year%-%Month%-%Day%
echo
echo Last Updated:%LASTUPDATE%
echo
echo Checking for Electra folder...
IF EXIST %APPDATA%\Electra\ (
mkdir %SYSTEMDRIVE%\ElectraWalletBackup\
echo Copying wallet.dat to %USERPROFILE%\Documents\ElectraWalletBackup
copy %APPDATA%\Electra\wallet.dat %SYSTEMDRIVE%\ElectraWalletBackup\ /y
copy %APPDATA%\Electra\wallet.dat %SYSTEMDRIVE%\ElectraWalletBackup\%today%wallet.dat /y
echo
echo wallet.dat successfully backedup!
echo
echo Press any key to open up the backedup folder...
pause
explorer %SYSTEMDRIVE%\ElectraWalletBackup\
echo
pause
GOTO MENU
) ELSE (
echo No Electra folder detected.
echo wallet.dat backup failed!
echo Exiting...
pause
GOTO MENU
)

:BLOCKREMOVAL
echo
echo -=ECA User Spport Fix-o-Lot=-
echo
echo Last Updated:%LASTUPDATE%
echo
echo Protecting files wallet.dat, peers.dat, and Electra.conf...
echo
attrib +r %APPDATA%\Electra\wallet.dat
attrib +r %APPDATA%\Electra\Electra.conf
attrib +r %APPDATA%\Electra\peers.dat
echo Now deleting Electra wallet files except protected files...
echo
del /S /Q %APPDATA%\Electra\*.*
rmdir /Q %APPDATA%\Electra\database
rmdir /Q %APPDATA%\Electra\txleveldb
echo
echo Files Deleted
echo
attrib -r %APPDATA%\Electra\wallet.dat
attrib -r %APPDATA%\Electra\Electra.conf
attrib -r %APPDATA%\Electra\peers.dat
echo Unlocking files wallet.dat, peers.dat and Electra.conf to be used for wallet...
echo
echo Files Unlocked
echo
echo When you are finished, please run the wallet and the files will automatically install.
echo
echo *******NOTE***** Your coins will NOT appear until it is fully synced!
echo
echo Highly recommend go back to the menu and run the peers.dat if had sync problems
echo
pause
GOTO MENU 

:MNENOMIC
echo
echo -=ECA User Spport Fix-o-Lot=-
echo
echo Last Updated:%LASTUPDATE%
echo
SET /P I=Your wallet needs to be backedup first, is your wallet backed up [y/n]: 
if NOT "%I%"=="y" (
echo
echo Returning to menu...
pause
GOTO MENU
)
echo
echo You MUST have your mnenomic phrase and passphrase before you start this! No Exception!
echo
SET /P K=Type [y/n] press ENTER: 
if NOT "%K%"=="y" (
echo
echo Returning to menu...
pause
GOTO MENU
)
echo
echo Press anykey to automatically close the wallet.
pause
taskkill /F /IM  "Electra Desktop.exe" /T  >nul 2>&1
taskkill /F /IM  "electrad-windows.exe" /T  >nul 2>&1
taskkill /F /IM  "Electra-qt.exe" /T  >nul 2>&1
cls
echo
echo Deleting files for fix...
rmdir /S /Q "%APPDATA%\Electra Desktop"
echo
echo Files deleted...
echo 
echo ****STOP and READ****
echo
echo Next, a older wallet version will be installed for recovery purposes. First, fill out the passphrase for your QT or New Wallet.
echo
echo If you are recoving a wallet, click Recover a Wallet Via Mnemonic. DO NOT PUT ANYTHING in the extension spot unless told to by User Support!
echo
echo You will need to complete this step and continue till you get to the white main screen in the wallet.
echo
echo Once you see this white main screen in the wallet, come back to this command prompt and follow the directions.
echo
echo Do NOT close the wallet!!!!
echo
echo **********************
echo
pause
start %ELECTRAOLD%
:MYLOOP
echo
SET W=NULL
SET /P W=Type the word "done" with no quotes when you see the main white screen on the wallet and press Enter: 
if NOT "%W%"=="done" GOTO MYLOOP
echo
echo Press anykey to automatically close the wallet.
pause
taskkill /F /IM  "Electra Desktop.exe" /T >nul 2>&1
taskkill /F /IM  "electrad-windows.exe" /T >nul 2>&1
taskkill /F /IM  "Electra-qt.exe" /T >nul 2>&1
cls
echo
echo Upgrading to newest wallet...
echo
echo Fill out your passphrase when asked.
echo
echo Pressing any key will start the installer.
echo
pause
start %ELECTRAFILE%
echo
echo It is recommended to run the peers.dat file if you are having syncing issues.
pause
echo
echo Return to menu...
pause
GOTO MENU

:UPGRADE
echo
echo -=ECA User Spport Fix-o-Lot=-
echo
echo Last Updated:%LASTUPDATE%
echo
echo Press anykey to automatically close the wallet.
pause
taskkill /F /IM  "Electra Desktop.exe" /T >nul 2>&1
taskkill /F /IM  "electrad-windows.exe" /T >nul 2>&1
taskkill /F /IM  "Electra-qt.exe" /T >nul 2>&1
echo
echo Ready to launch the new install...
echo Follow the install and this script will return to the main menu
pause
start "" %ELECTRAFILE%
GOTO MENU

:EXPERTQUIT
echo
echo -=ECA User Spport Fix-o-Lot=-
echo
echo Last Updated:%LASTUPDATE%
echo
echo Press anykey to automatically close the wallet.
pause
taskkill /F /IM  "Electra Desktop.exe" /T >nul 2>&1
taskkill /F /IM  "electrad-windows.exe" /T >nul 2>&1
taskkill /F /IM  "Electra-qt.exe" /T >nul 2>&1
echo
echo Wallets closed. Return to menu...
echo
pause
GOTO MENU

:EXIT
exit