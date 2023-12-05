function Write-Log {
    param (
        [string]$Message,
        [string]$Level = "INFO",
        [string]$LogFile = "XamppCheckLog.txt"
    )

    # Format de date compatible avec log4j et NLog
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

    # Création du message formaté
    $logMessage = "$timestamp [$Level] $Message"

    # Écriture dans le fichier de logs
    Add-Content -Path $LogFile -Value $logMessage

    # Affichage dans la console
    Write-Host $logMessage
}

# Fonction pour vérifier la disponibilité des ports et proposer de tuer les processus occupant ces ports
function VerifierPorts {
    param (
        [int[]]$ports = @(80, 443, 3306)
    )
    
    foreach ($port in $ports) {
        $process = Get-NetTCPConnection -LocalPort $port -ErrorAction SilentlyContinue
        if ($process) {
            Write-Log "Port $port est utilisé par le processus $($process.OwningProcess) ($(Get-Process -Id $process.OwningProcess).ProcessName)"
            $response = Read-Host "Voulez-vous tuer ce processus ? (o/n)"
            if ($response -eq 'o') {
                Stop-Process -Id $process.OwningProcess -Force
                Write-Log "Processus sur le port $port tué."
            }
        } else {
            Write-Log "Port $port disponible"
        }
    }
}

# Fonction pour vérifier l'intégrité de la base de données MySQL
function VerifierBaseMySQL {
    # Emplacement du répertoire de données MySQL
    $dataPath = "mysql/data"

    # Vérifier l'existence des fichiers ibdata
    if (Test-Path "$dataPath\ibdata1") {
        Write-Log "La base de données MySQL semble intacte."
    } else {
        Write-Log "La base de données MySQL pourrait être corrompue."
    }
}

# Fonction pour vérifier si le script setup_xampp.bat a été exécuté
function VerifierSetupXampp {
    # Chemin vers le fichier php.ini
    $phpIniPath = Join-Path $PSScriptRoot "php\php.ini"

    # Vérifier si le fichier php.ini existe
    if (Test-Path $phpIniPath) {
        # Lire le contenu du fichier php.ini
        $phpIniContent = Get-Content $phpIniPath

        # Rechercher la ligne contenant 'include_path'
        $includePathLine = $phpIniContent | Where-Object { $_ -match '^\s*include_path\s*=' }

        if ($includePathLine) {
            # Extraire le chemin d'include_path
            $includePath = ($includePathLine -split '=' | Select-Object -Last 1).Trim()

            # Construire le chemin d'accès complet en ajoutant la lettre de lecteur
            $driveLetter = (Get-Location).Drive.Name
            $fullIncludePath = Join-Path "${driveLetter}:" $includePath

            # Vérifier si le chemin d'accès existe
            if (Test-Path $fullIncludePath) {
                Write-Log "Le chemin d'include_path ($fullIncludePath) existe. Le script setup_xampp.bat semble être avoir été exécuté correctement."
            } else {
                Write-Log "Le chemin d'include_path ($fullIncludePath) n'existe pas. Le script setup_xampp.bat pourrait ne pas avoir été exécuté correctement."
            }
        } else {
            Write-Log "La ligne 'include_path' n'a pas été trouvée dans php.ini."
        }
    } else {
        Write-Log "Le fichier php.ini est introuvable à l'emplacement $phpIniPath."
    }
}

# Script principal
function DiagnosticXampp {
    # Créer ou ouvrir le fichier de log
    
    Write-Log "Début du diagnostic - $(Get-Date)"

    # Exécuter les fonctions de diagnostic
    VerifierPorts
    VerifierBaseMySQL
    VerifierSetupXampp

    # Écrire dans le fichier de log
    Write-Log "Diagnostic terminé - $(Get-Date)"
    Write-Log "Diagnostic terminé" -Level "DEBUG"
}

# Lancer le diagnostic
DiagnosticXampp
