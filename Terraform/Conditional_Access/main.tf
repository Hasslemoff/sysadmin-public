resource "msgraph_resource" "ca_exo_require_mfa" {
  url  = "identity/conditionalAccess/policies"
  body = {
    displayName = "Require MFA for Exchange Online"
    state       = "enabled"
    conditions  = {
      clientAppTypes = [
        "mobileAppsAndDesktopClients",
        "browser"
      ]
      applications = {
        includeApplications = [
          "00000002-0000-0ff1-ce00-000000000000" # Exchange Online
        ]
      }
      users = {
        includeGroups = ["groupId"]
      }
      locations = {
        includeLocations = ["All"]
        excludeLocations = ["AllTrusted"]
      }
    }
    grantControls = {
      operator         = "OR"
      builtInControls = ["mfa"]
    }
  }
}

resource "msgraph_resource" "block_legacy_auth" {
  url = "identity/conditionalAccess/policies"
  body = {
    displayName = "Via MSGraph - Block Legacy Authentication"
    state       = "enabledForReportingButNotEnforced"
    conditions = {
      users = {
        includeUsers  = ["All"]
        excludeUsers  = []
        includeGroups = []
        excludeGroups = []
        includeRoles  = []
        excludeRoles  = []
      }
      applications = {
        includeApplications                         = ["All"]
        excludeApplications                         = []
        includeUserActions                          = []
        includeAuthenticationContextClassReferences = []
        applicationFilter                           = null
      }
      clientAppTypes = [
        "exchangeActiveSync",
        "other"
      ]
      platforms = {
        includePlatforms = ["all"]
        excludePlatforms = []
      }
      locations = {
        includeLocations = ["All"]
        excludeLocations = []
      }
      authenticationFlows = {
        transferMethods = "none"
      }
      signInRiskLevels           = []
      userRiskLevels             = []
      servicePrincipalRiskLevels = []
    }
    grantControls = {
      operator                    = "OR"
      builtInControls             = ["block"]
      customAuthenticationFactors = []
      termsOfUse                  = []
      authenticationStrength      = null
    }
    sessionControls = {
      applicationEnforcedRestrictions = null
      cloudAppSecurity                = null
      signInFrequency                 = null
      persistentBrowser               = null
      continuousAccessEvaluation      = null
      secureSignInSession             = null
      disableResilienceDefaults       = null
    }
  }
}