# CAPSTONE PROJECT 7- AUTOMATING DEPLOYMENT OF AN E-COMMERCE WEBSITE! - CI/CD MASTERY

## Project Scenario
In this project, I am tasked to design and implement a robust CI/CD pipeline using Jenkins to automate the deployment of a web application. The goal is to achieve continuous integration, continuous deployment and ensure the scalability and reliability of the applications.

## Project Components
1. JENKINS SERVER SETUP
2. SOURCE CODE MANAGEMENT REPOSITORY INTEGRATION
3. JENKINS FREESTYLE JOBS FOR BUILD AND UNIT TESTS
4. JENKINS PIPELINE FOR WEB APPLICATION
5. DOCKER IMAGE CREATION AND REGISTRY PUSH

## STEP 1: JENKINS SERVER SETUP
## TASKS
1. Install Jenkins on a dedicated server: I launched an AWS ec2 instance and connected to it using ssh.

![](./images/01.%20Launching%20an%20instance%20for%20jenkins%20installation.png)


2. Installing Jenkins on the instance and ensure it has been installed and is up and running.

* Update package repositories
```bash
sudo apt update
```
* Install JDK 
```bash
sudo apt install default-jdk-headless
```
* Install Jenkins
```bash 
wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
/etc/apt/sources.list.d/jenkins.list'
sudo apt update
sudo apt-get install jenkins
```
* Check if Jenkins has been installed and it'ss up and running
```bash
sudo systemctl status jenkins
```
![](./images/02.%20Jenkins%20installed%20and%20running.png)

* On the Jenkins instance, I have to create a new inbound rule for port 8080 in the security group.

`By default, jenkins listens on port 8080`

![](./images/03.%20add%20security%20grp%20on%20port%208080.png)

3. Setting up Jenkins on the Web Console
* Input the Jenkins instance ip address on my web browser, this takes me to unlock jenkins.
```bash
18.223.158.29:8080
```
* An administrator password is asked for which can be found in the jenkins instance 
```bash
sudo cat var/lib/jenkins/secrets/initialAdminPassword
```
* Installing suggested plugins

![](./images/04.%20install%20pluggins.png)
* Creating a user account with your personal details

* Login to Jenkins console

![](./images/05.%20jenkins%20console.png)

## STEP 2: SOURCE CODE MANAGEMENT REPOSITORY INTEGRATION & JENKINS FREESTYLE JOBS FOR BUILD AND UNIT TESTS
## TASKS
1. Cloning into the existing githb repo i want to use for this project for source code management.

![](./images/06.%20cloning%20projects%20repo.png)

2. From the dashboard menu of the jenkins concole, clicked on new item and created a freestyle project and named it `my-first-freestyle`

![](./images/07.%20freestyle%20project.png)

3. Connecting jenkins to our source code management (`github`). 
I pasted the github repository url in the jenkins freestyle job configuration.

![](./images/08.connecting%20jenkins%20to%20github.png)
![](./images/09.%20source%20code%20management.png)

4. __Configure a build trigger:__ 
As a DevOps Engineer I need to automate things and make work easier and possible.To eliminate clicking on `Build now`
to run a new build, we need to configure a build trigger to our jenkins app. With this, jenkins will run a new build anytime a change is made to our github repository.

![](./images/10.%20github%20hook%20trigger%20for%20GITScm%20polling.png)

5. Configure webhooks for automatic triggering of Jenkins build. We will create a github webhook using jenkins ip address and port. Webhook can be found in the repo settings.

![](./images/11.%20conncting%20github%20webhook.png)

6. Making changes to my github repository files to test if the integration and connection worked for automatic new build.

* Webhook won't be triggered unless I push a file from git to github.

![](./images/12.%20making%20changes%20to%20webhook.png)

* I created a new folder `07. CICD_MASTERY`, added, comit changes and pushed to my github repo.

![](./images/13.%20create%20a%20new%20folder%20for%20project.png)


* Trigger successful after pushing to github and new build launches automatically.

![](./images/14.%20trigger%20successfull.png)
![](./images/15.new%20build%20launches%20automatically%20after%20push%20to%20github.png)

## STEP 3: JENKINS PIPELINE FOR WEB APPLICATION AND DOCKER IMAGE CREATION AND REGISTRY PUSH
## TASKS
1. Creating a Jenkins Pipeline Job: From the dashboard menu of the jenkins concole, clicked on new item and created a pipeline job and named it `my-first-pipeline`.

![](./images/16.%20creating%20pipeline.png)

2. Configure build trigger to configure triggering the job from Github webhook. Since i created a github webhook for the repository previously, I do ot need to create another one again.

![](./images/17.%20configure%20github%20hook%20trigger.png)

3. Install docker on the same instance where jenkins was installed. We need to do this before jenkins can run docker commands.

* Installing with a shell script. created a file and pasted the script below inside, saved and executed the file.
```bash
touch docker.sh
chmod u+w docker.sh
vi docker.sh
./docker.sh
```
```bash
sudo apt-get update -y
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo systemctl status docker
```

![](./images/18.%20script%20to%20install%20docker.png)

* Docker installed and running.

![](./images/19.%20docker%20installed%20and%20running.png)


4. Generate jenkins pipeline script: 

A jekins pipeline script is a script that defines and orchestrates the steps and stages of continuous integration and continuous delivery pipeline.
```bash
pipeline \{
    agent any 

    stages \{		
        stage('Connect To Github') \{
            steps \{
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/DevOyinda/DevOps-Capstone-Projects.git']])		
            \}
        \}
        stage('Build Docker Image') \{		
            steps \{
                script \{
                    sh 'docker build -t dockerfile .'
                \}
            \}
        \}
        stage('Run Docker Container') \{
            steps \{
                script \{
                    sh 'docker run -itd -p 8081:80 dockerfile'
                \}
            \}
        \}
    \}
\}
```

`agent any` - 	PIPELINE CAN RUN ON ANY AVAILABLE AGENT

`stages \{ stage('Connect To Github') \}` - DEFINES VARIOUS STAGES OF A PIPELINE 

`checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs:[[url: 'https://github.com/DevOyinda/DevOps-Capstone-Projects.git']])` - THIS STAGE CHECKS OUT THE SOURCE CODE FROM A GITHUH REPO. SPECIFIES PIPELINE SHOULD USE MAIN BRANCH

This script configures jenkins to build docker images and run a container with the built docker image.

![](./images/20.%20generate%20pipeline%20script%20to%20build%20docker.png)

* To generate syntac for the github repository, click on `pipeline syntax` directly under the script pasted.

![](./images/21.%20pipeline%20syntax%20generator.png)

* Snippet generator generates a pipeline script for you. 

![](./images/22.%20%20script%20generated.png)


5. __Building pipeline script__ : Now that we have installed docker in the same instance with jenkins earlier, we need to create a dockerfile before we can run the pipeline script. 
`We cannot build a docker image without a dockerfile`

* Create a new file named `dockerfile`
```bash
touch dockerfile
```
* Paste the code in the file
```bash
vi dockerfile
```
```bash
# Use the official NGINX base image
FROM nginx:latest

# Set the working directory in the container
WORKDIR  /usr/share/nginx/html/

# Copy the local HTML file to the NGINX default public directory
COPY index.html /usr/share/nginx/html/

# Expose port 80 to allow external access
EXPOSE 80
```

![](./images/23.%20create%20a%20dockerfile.png)

* Have a static website application folder having an html file.

![](./images/24.%20signup%20folder%20with%20html%20file.png)

* Push these new changes to github.

![](./images/25.%20push%20changes%20to%20github.png)

* The pushing should automatically run a new build for our jenkins pipeline

SUCCESSFUL BUILD

![](./images/26.%20automatically%20ran%20new%20build%20after%20making%20changes.png)

* To access the contents of the index.html file from out statis web application on our web browser, you will need to edit inbound rules and open the port we mapped our docker container to - `port 8081`

![](./images/27.%20add%20nbound%20rules%20to%20port%208081.png)

* We can now access our static website on the web browser using the instance ip-address `18.223.158.29:8081`

![](./images/28.%20website%20access%20on%20port%208081.png)


6. __Push Docker Images to Container Registry (Docker Hub)__
* I generated a jenkins pipeline script to push the docker image created to Docker Hub.

```bash
pipeline {
    agent any
    
     environment {
        DOCKER_IMAGE = 'devoyinda/cicd-mastery-capstone-project-7' // Replace with your Docker Hub image name
        DOCKER_TAG = '3.0' // Replace with your desired tag
        DOCKER_CREDENTIALS = 'dockerhub_credentials' // Replace with the ID of your Jenkins credentials
        DOCKER_USERNAME = 'devoyinda'
        DOCKER_PASSWORD = credentials('dockerhub_credentials') // Credentials ID
    }
    
    
    stages {
        stage('Connect To Github') {
            steps {
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/DevOyinda/DevOps-Capstone-Projects.git']])
            }
        }
        stage('Build Docker Image') {
            steps {
                    // Navigate to the directory containing the Dockerfile
                    dir('07.CICD-Mastery') {
                        script {
                        // Build the Docker image
                        docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}")
                    }    
                }
            }
        }
        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    // Push the Docker image to Docker Hub
                    docker.withRegistry('https://registry.hub.docker.com', ("${DOCKER_CREDENTIALS}")) {
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                    }
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                     // Check if port 8081 is in use
                    def isPortInUse = sh(script: "docker ps --filter 'publish=8081' --format '{{.ID}}'", returnStdout: true).trim()

                    if (isPortInUse) {
                        // Stop and remove the existing container using port 8081
                        sh "docker stop ${isPortInUse}"
                        sh "docker rm ${isPortInUse}"
                    }
                     // Run a new container using the built image
                    sh 'docker run -itd -p 8081:80 devoyinda/cicd-mastery-capstone-project-7:3.0'
                }
            }
        }
    }
}
```

![](./images/30.%20generate%20pipeline%20to%20push%20to%20docker%20hub.png)

* Successful build

![](./images/31.%20successful%20build.png)
![](./images/32.%20successful%20build.png)

* Docker imaged pushed to docker hub registry

![](./images/33)





# TROUBLESHOOTING ISSUES - Failed automated tests blocking the pipeline
In this project, I frequently encountered build failures in Jenkins whenever I made changes to my GitHub repository. The error indicated that a container was already running, requiring me to either stop it manually or assign the new container to a different port. As a result, I had to constantly modify security groups, stop existing containers, or even delete them to allow a new one to run.

Beyond Continuous Integration, Jenkins also excels in automation, streamlining the testing process to minimize manual effort and ensure software quality.

To resolve the issue, I modified the pipeline script to automatically stop and remove any running container before starting a new one with the updated build. This ensured that builds could run seamlessly without failures when changes were pushed to the repository.

```bash
pipeline {
    agent any

    stages {
        stage('Connect To Github') {
            steps {
                    checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/DevOyinda/DevOps-Capstone-Projects.git']])
            }
        }
        stage('Build Docker Image') {
            steps {
                    // Navigate to the directory containing the Dockerfile
                    dir('07.CICD-Mastery') {
                        // Build the Docker image
                    sh 'docker build -t dockerfile .'
                }
            }
        }
        stage('Run Docker Container') {
            steps {
                script {
                     // Check if port 8081 is in use
                    def isPortInUse = sh(script: "docker ps --filter 'publish=8081' --format '{{.ID}}'", returnStdout: true).trim()

                    if (isPortInUse) {
                        // Stop and remove the existing container using port 8081
                        sh "docker stop ${isPortInUse}"
                        sh "docker rm ${isPortInUse}"
                    }
                     // Run a new container using the built image
                    sh 'docker run -itd -p 8081:80 dockerfile'
                }
            }
        }
    }
}
```

![](./images/29.%20troubleshooting.png)

SUCCESSFUL BUILD AFTER 7 ATTEMPTS.

![](./images/26.%20automatically%20ran%20new%20build%20after%20making%20changes.png)


## **For a large-scale business running multiple applications simultaneously, repeatedly stopping and removing containers with each build is not the most efficient approach. Instead, I would adopt a more effective container management strategy that ensures high availability, scalability, and automation.**