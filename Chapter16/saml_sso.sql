CREATE OR REPLACE SECURITY INTEGRATION idp_saml
  TYPE = SAML2
  ENABLED = TRUE
  SAML2_ISSUER = 'https://idp.example.com/app/...'
  SAML2_SSO_URL = 'https://idp.example.com/sso/...'
  SAML2_X509_CERT = '-----BEGIN CERTIFICATE-----...'
  -- Optional: map IdP attributes to Snowflake session context
  SAML2_SP_INITIATED_LOGIN_PAGE_LABEL = 'Corporate SSO';
