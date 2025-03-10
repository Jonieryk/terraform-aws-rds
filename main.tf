module "db" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "demo-2"

  engine            = "mysql"
  engine_version    = "5.7"
  instance_class    = "db.t3.large"
  allocated_storage = 5

  db_name  = "wordpress"
  username = "wordpress"
  port     = "3306"

  iam_database_authentication_enabled = true

  vpc_security_group_ids = ["sg-03be0383913cf47cd"]

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"

  # Enhanced Monitoring - see example for details on how to create the role
  # by yourself, in case you don't want to create it automatically
  monitoring_interval    = "30"
  monitoring_role_name   = "MyRDSMonitoringRole"
  create_monitoring_role = true

  tags = {
    Owner       = "user"
    Environment = "dev"
  }

  # DB subnet group
  create_db_subnet_group = true
  subnet_ids             = ["subnet-0c08afaab3a0cc725", "subnet-03650f10d8af594a6", "subnet-0f7c6f69a0edb05ab"]

  # DB parameter group
  family = "mysql5.7"

  # DB option group
  major_engine_version = "5.7"

  # Database Deletion Protection
  deletion_protection = false

  parameters = [
    {
      name  = "character_set_client"
      value = "utf8mb4"
    },
    {
      name  = "character_set_server"
      value = "utf8mb4"
    }
  ]

  options = [
    {
      option_name = "MARIADB_AUDIT_PLUGIN"

      option_settings = [
        {
          name  = "SERVER_AUDIT_EVENTS"
          value = "CONNECT"
        },
        {
          name  = "SERVER_AUDIT_FILE_ROTATIONS"
          value = "37"
        },
      ]
    },
  ]
}