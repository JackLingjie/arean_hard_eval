To check your system drive for errors on Windows, follow these steps:

1. Open the Start menu and type "Command Prompt" in the search bar.
2. Right-click on "Command Prompt" and select "Run as administrator".
3. In the Command Prompt window, type the following command and press Enter:
```
chkdsk C: /f
```
Replace "C:" with the letter of your system drive if it is different.

4. The chkdsk utility will scan your system drive for errors and attempt to fix them. It may take a few minutes to complete, so be patient.

5. Once the scan is complete, restart your computer to apply any changes made by chkdsk.

Note: If you receive an error message stating that chkdsk cannot run because the volume is in use, you can try running the command with the /r option, which will force chkdsk to run even if the volume is in use.