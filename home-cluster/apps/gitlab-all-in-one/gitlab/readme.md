
Caused by:
PG::ConnectionBad: connection to server at "10.43.132.250", port 5432 failed: FATAL:  password authentication failed for user "gitlab"
/srv/gitlab/vendor/bundle/ruby/3.2.0/gems/pg-1.6.1-x86_64-linux/lib/pg/connection.rb:751:in `polling_loop'

psql -U postgres   # log in to  use `postgres-password` key

need to update gitlab password inside psql database
\password gitlab, and put `password` key from secret there 

gitlab-rails console
gitlab-rake db:migrate   # separate command dont run inside console


minio secrets needs to be alphanumeric 


500 error when tying to go to runners page, need to reset token, they cant be decrypted
irb(main):002> g = Group.find_by_id(3)
=> #<Group id:3 @groupname>
irb(main):003> g.update_columns(runners_token: nil, runners_token_encrypted: nil)


SELECT runners_registration_token_encrypted, encrypted_ci_jwt_signing_key FROM application_settings;

# check if encrypted secrets are working
gitlab-rake gitlab:doctor:secrets

# sets all token fields to null, if says that field doesnt exist then it is null already
ApplicationSetting.update_all(
  runners_registration_token_encrypted: nil,
  encrypted_asset_proxy_secret_key: nil,
  encrypted_secret_detection_token_revocation_token: nil,
  encrypted_ci_jwt_signing_key: nil,
  error_tracking_access_token_encrypted: nil,
  slack_app_secret: nil,
  slack_app_signing_secret: nil,
  encrypted_vault_server_auth_data: nil,
  instance_statistics_measurement_key: nil,
  encrypted_personal_access_token_key: nil,
  encrypted_mattermost_session_secret: nil
)

# Clear Runner Tokens
Ci::Runner.update_all(token_encrypted: nil)
Project.update_all(runners_token_encrypted: nil)
Namespace.update_all(runners_token_encrypted: nil)

# Clear Webhook Tokens
WebHook.update_all(token: nil, token_encrypted: nil)

# Clear Deploy Tokens
DeployToken.update_all(token_encrypted: nil)


Integration.update_all(properties: nil, encrypted_properties: nil)
Service.update_all(properties: nil, encrypted_properties: nil)
Clusters::Platforms::Kubernetes.update_all(token_encrypted: nil)