Configuration ServerRegistry {

    # Import the module that contains the resources we're using.
    Import-DscResource -ModuleName @{ModuleName="PsDesiredStateConfiguration";ModuleVersion="1.1"}

    # The Node statement specifies which targets this configuration will be applied to.
    Node 'localhost' {

        # Ensures the WUServer key is present
        Registry WindowsUpdateServer {
            Ensure = "Present"
            Force = $True
            Key =  "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
            ValueName = "WUServer"
            ValueData = "http://vmprodutil13"
        }

        # Ensures the WUStatusServer Key is present
        Registry WindowsUpdateStatusServer {
            Ensure = "Present"
            Force = $True
            Key =  "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate"
            ValueName = "WUStatusServer"
            ValueData = "http://vmprodutil13"
        }
        # Ensures Windows Update is set to Notify Before Download
        Registry WindowsUpdateOptions {
            Ensure = "Present"
            Force = $True
            Key =  "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
            ValueName = "AUOptions"
            ValueData = "2"
        }

        #Ensures that Windows uses the Server specified previously
        Registry WindowsUpdateServerStatus {
            Ensure = "Present"
            Force = $True
            Key =  "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU"
            ValueName = "UseWUServer"
            ValueData = "1"
        }
        #Ensures that UAC is disabled
        Registry DisableUAC {
            Ensure = "Present"
            Force = $True
            Key =  "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
            ValueName = "EnableLUA"
            ValueData = "0"
        }
    }
}