Setting up Rancher on AWS
============================


This guide is designed for those who want a hassle free setup of Rancher using RancherOS on AWS using Cloudformation templates.  These are provided as as close to "Ready to use" as possible, with the exception that the Rancher Server is not HA, only single instance.

# Stack information

The stacks are very customisable, including an RDS instance for database storage of the Rancher Server, a single EC2 instance for Rancher Server and several instances for the Rancher nodes.  There is a security group for the RDS instance.

## Step 1

Create security group for RDS instance by uploading the rds-security-group template.  This is simple to allow access to the database from the server.

### Step 2

Create the MySQL instance by uploading the RDS template.  If the Rancher server goes down, all your data will be stored here.  Create this by uploading the RDS template and use the RancherRDSSecurityGroup ID resource you just created.  This will be found in the Resources tab in the AWS console.

### Step 3

Create the Rancher Server instance by uploading the rancher template.  This instance will run on top of RancherOS, you will need to use the RDSComponentSecurityGroup as well as all of the MySQL details from the RDS section of the AWS Console.  

Once completed, the Rancher server will be available at the load balancer URL found in the Load Balancer section in the EC2 Console.

If running RancherOS is not an option, you will need to chance the UserData section to remove the Rancher specific start up options.

### Step 4

Create the Rancher Nodes.  If you are going to use to use the load balancer URL rather than a domain you own, visit that in your browser, otherwise you can use a domain you own via a service such as Route53.  

When you first visit Rancher, it will ask you to set up authentication, probably via Github, set this up as prompted and then visit the infrastructure tab.  

Click add custom node and copy the URL.

Upload the nodes template and add in your Rancher Server URL without any of the docker commands.  This should connect your nodes to your Rancher Server.
