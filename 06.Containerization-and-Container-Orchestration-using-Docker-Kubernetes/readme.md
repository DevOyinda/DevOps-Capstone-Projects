# CAPSTONE PROJECT 6: CONTAINERIZATION AND CONTAINER ORCHESTRATION

## Project Scenario
In this project, I will be containerizing a simple static website (HTML & CSS) for a company's sign-up page. This application will be containerised using docker, deployed to kubernetes cluster and accessed using nginx.

## Project Objectives
1. Setup  dicrectory and create html & css files
2. Implement with git
3. Dockerize the application
4. Push to Docker hub
5. Setting up and using Kubernetes Cluster
6. Accessing Deployed Application

## Step 1: Setup and Git Initialization
## Tasks:
1. Create a new project directory.
```bash
mkdir 06.Containerization-and-Container-Orchestration-using-Docker-Kubernetes
```
2. Create a new `index.html` file and use text editor vim to add the code to the file.
```bash
touch index.html
vim index.html 
```

Paste the code below
```bash
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1.0" />
		<!-- displays site properly based on user's device -->

		<link
			rel="icon"
			type="image/png"
			sizes="32x32"
			href="./img/favicon-32x32.png"
		/>

		<title>Responsiveness and Media Queries</title>

		<link rel="stylesheet" href="style.css" />
	</head>
	<body>
		<div class="container">
			<div>
				<h1>
					Learn to code by
					<br />
					watching others
				</h1>
				<p>
					See how experienced developers solve problems in real-time. Watching
					scripted tutorials is great, but understanding how developers think is
					invaluable.
				</p>
			</div>
			<div>
				<div class="box box-blue">
					<p>
						<strong>Try it free 7 days</strong>
						then $20/mo. thereafter
					</p>
				</div>

				<form class="box" id="form">
					<div class="form-control">
						<input type="text" id="firstname" placeholder="First Name" />
						<img src="./img/icon-error.svg" alt="error-icon" />
						<small></small>
					</div>
					<div class="form-control">
						<input type="text" id="lastname" placeholder="Last Name" />
						<img src="./img/icon-error.svg" alt="error-icon" />
						<small></small>
					</div>
					<div class="form-control">
						<input type="email" id="email" placeholder="Email Address" />
						<img src="./img/icon-error.svg" alt="error-icon" />
						<small></small>
					</div>
					<div class="form-control">
						<input type="password" id="password" placeholder="Password" />
						<img src="./img/icon-error.svg" alt="error-icon" />
						<small></small>
					</div>

					<button>Claim your free trial</button>
					<small>
						By clicking the button, you are agreeing to our
						<a href="#">Terms and Services</a>
					</small>
				</form>
			</div>
		</div>

	</body>
</html>
```

3. Create a new `style.css` file and use text editor vim to add the code to the file.

```bash
touch style.css
vim style.css 
```
Paste the code
```bash
@import url('https://fonts.googleapis.com/css?family=Poppins:400,500,600,700&display=swap');

* {
	box-sizing: border-box;
}

body {
	background-color: hsl(0, 100%, 74%);
	background-image: url('./images/bg-intro-desktop.png');
	color: #fff;
	font-family: 'Poppins', sans-serif;
}

.container {
	display: flex;
	align-items: center;
	justify-content: center;
	flex-wrap: wrap;
	max-width: 1200px;
	margin: 0 auto;
	min-height: 100vh;
}

.container > div {
	flex: 1;
	padding: 0 20px;
}

h1 {
	font-size: 40px;
	line-height: 50px;
}

p {
	font-size: 15px;
	opacity: 0.8;
}

.box {
	background-color: #fff;
	border-radius: 5px;
	box-shadow: 0 6px rgba(0, 0, 0, 0.2);
	padding: 30px;
	margin-bottom: 20px;
	text-align: center;
}

.box p {
	margin: 0;
}

.box-blue {
	background-color: hsl(248, 32%, 49%);
	padding: 20px;
}

.form-control {
	position: relative;
	margin-bottom: 30px;
}

.form-control small {
	color: hsl(0, 100%, 74%);
	font-weight: 600;
	position: absolute;
	bottom: -24px;
	right: 0;
	opacity: 0;
	text-align: right;
}

input {
	border-radius: 5px;
	border: 1.3px solid hsl(246, 25%, 77%);
	font-family: 'Poppins', sans-serif;
	font-size: 14px;
	font-weight: 500;
	padding: 15px 25px;
	display: block;
	width: 100%;
}

.form-control.error input {
	border-color: hsl(0, 100%, 74%);
	color: hsl(0, 100%, 74%);
}

.form-control.error input::placeholder {
	color: hsl(0, 100%, 74%);
}

input:focus {
	border: 1.3px solid hsl(248, 32%, 49%);
	outline: none;
}

.form-control img {
	opacity: 0;
	position: absolute;
	top: 50%;
	right: 15px;
	transform: translateY(-50%);
	height: 20px;
}

.form-control.error img {
	opacity: 1;
}

button {
	background-color: hsl(154, 59%, 51%);
	border-radius: 5px;
	border: 1px solid hsl(154, 59%, 45%);
	box-shadow: 0 2px hsl(154, 59%, 45%);
	color: #fff;
	cursor: pointer;
	display: block;
	font-family: 'Poppins', sans-serif;
	font-size: 14px;
	font-weight: 500;
	padding: 15px 25px;
	letter-spacing: 1px;
	text-transform: uppercase;
	width: 100%;
}

button:focus {
	outline: none;
}

button:active {
	box-shadow: 0 0 hsl(154, 59%, 45%);
	transform: translateY(2px);
}

.form-control small {
	opacity: 0;
}

.form-control.error small {
	opacity: 1;
}

small {
	display: block;
	color: #bbb;
	font-size: 11px;
	font-weight: 500;
	margin-top: 15px;
}

small a {
	color: hsl(0, 100%, 74%);
	font-weight: 600;
	text-decoration: none;
}

@media screen and (max-width: 768px) {
	h1 {
		text-align: center;
	}

	p {
		text-align: center;
	}

	.container {
		flex-direction: column;
	}
}
```

4. Git add, commit & push the files created to github.
```bash
git add .
git commit -m "Added files"
git push
```
![](./images/01.created%20directory,%20files,%20git%20add,%20commit%20&%20push.png)

## Step 2: Dockerize the Application
I decided to containerize and orchestrate the application on an EC2 instance. I creeated an instance, started it and connected to it.

SSH into Ec2 instance.
![](./images/02.ssh%20into%20ec2%20instance.png)

## Tasks:
1. Creating dockerfile.
- I created a directory named `capstone` (directory for index.html file & dockerfile).
- In the capstone directory created, I created another directory called Signup_page where the index.html & style.css files were stored.
- Create a dockerfile in the capstone directory.

```bash
touch dockerfile
vim dockerfile
```
![](./images/03.created%20capstone%20folder%20for%20dockerfile&%20index.html%20files.png)

In the dockerfile specify nginx as the base image & copy index.html and the styles.css into the Nginx HTML directory.
![](./images/04.vi%20dockerfile.png)

### Breakdown of the Dockerfile above

This Dockerfile sets up a Docker image based on NGINX, a popular web server.

-  `FROM nginx`: This line specifies that we are using the official NGINX Docker image as the base image for our container. This means that our container will include all the necessary files and configurations to run NGINX.

-  `WORKDIR /usr/share/nginx/html`: This command sets the working directory within the NGINX container to /usr/share/nginx/html. This directory is typically where NGINX serves static HTML files from.

-  `COPY Signup_page`: This line copies the contents in that folder which is the index.html file & style.css file in the Signup_page directory from the build context (the directory where the Dockerfile is located) into the /usr/share/nginx/html directory within the container. 

- `EXPOSE 80`: This command exposes port 80 on the container. Port 80 is the default port for HTTP traffic, so by exposing it, we allow external clients to access our NGINX server running inside the container.

Overall, this Dockerfile is setting up a basic NGINX server with custom HTML (index.html) and CSS (styles.css) files served from the /usr/share/nginx/html directory, and it exposes port 80 to allow external access to the NGINX server.

2. Create/Build an image- ensuring you have Docker Desktop installed. If you are working on an EC2 instance, ensure Docker is installed on it. In my scenario, I am using my EC2 instance so i installed it in my instance.

Build an image using the dockerfile just created.
```bash
docker build -t dockerfile .
```
![](./images/05.build%20image%20using%20dockerfile.png)

3. Check the images list to verify the dockerfile image is already created
```bash
docker images 
```
![](./images/06.check%20images.png)

4. Run a container based on the image created and map it to a listening port
```bash
docker run -p 8080:80 dockerfile
```
![](./images/07.run%20container%20based%20on%20the%20image.png)

5. Check the list of available containers. Start a container and confirm it's running.
```bash
docker ps -a
docker start 19f13ddec815
docket ps
```
![](./images/08.check%20list%20of%20containers.png)

![](./images/09.start%20container%20and%20confirm%20its%20running.png)

6. Copy and paste the EC2 instance public IP Address including the port to view the webpage.

![](./images/10.get%20public%20ip%20of%20ec2%20instance.png)

![](./images/11.using%20ip-address%20and%20port%2080.png)

## Step 3: Push to Dockerhub
## Tasks:

1. Tag image! I already have a dockerhub account, I'll tag my image using my username and repository name then push.
```bash 
docker tag dockerfile devoyinda/my-capstone-proj-6:1.0
```
![](./images/12.tag%20image.png)

2. Login to docker hub
```bash
docker login -u devoyinda
```
![](./images/13.login%20to%20docker%20hub.png)

3. Push the image to docker hub
``` bash
docker push devoyinda/my-capstone-proj-6:1.0
```
![](./images/14.push%20image%20to%20docker%20hub.png)

## Step 4: Set up a Kind Kubernetes Cluster

This setup is to DEPLOY IMAGE TO KUBERNETES CLUSTER.

Kind runs Kubernetes clusters in Docker containers, so you will need Docker installed. I already have docker installed in my EC2 instance. 


## Tasks:
1. Install Kind (Kubernetes in Docker) & verify kind version
```bash
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```
![](./images/15.To%20install%20kind.png)
```bash
kind version
```
![](./images/16.Verify%20kind%20version.png)

2. Create a Kind Cluster
- Create a directory capstone-kind

cd into the directory

Run the command to create a Kind cluster:
```bash
 kind create cluster
```

This command will create a single-node Kubernetes cluster using Kind.

After creating cluster, you can verify that the cluster is running by executing:
```bash
kubectl cluster-info
```

![](./images/17.create%20kind%20cluster%20and%20verify%20cluster%20works.png)


3. Install kubectl
```bash
sudo snap install kubectl --classic
```
![](./images/18.kubectl%20installed.png)

4. Configure kubectl to point to the kind cluster

```bash
kubectl cluster-info --context kind-kind
```
![](./images/19.to%20configure%20kubectl%20to%20point%20to%20kind%20cluster.png)


5. Get cluster nodes
```bash
kubectl get nodes
```
![](./images/20.get%20cluster%20nodes.png)

## Step 5: Deploy to Kubernetes
## Tasks:
1. Create a Kubernetes YAML file. 

Write a Kubernetes Deployment configuration in a YAML file. This file describes the desired state for your application pods.
```bash
touch kub-deployment.yaml
vim kub-deployment.yaml
```
![](./images/21.%20create%20deployment%20yaml%20file.png)

This YAML configuration defines a Kubernetes Deployment named `signup-page` that manages a single replica of a containerized application. Let's break it down:

`apiVersion`: apps/v1: This specifies the API version being used. In this case, it's apps/v1, which is commonly used for managing higher-level abstractions like Deployments, StatefulSets, and DaemonSets.

`kind`: Deployment: Defines the type of Kubernetes resource being created, which is a Deployment. A Deployment manages a set of identical pods, ensuring that a specified number of them are running at any given time.

`metadata`: Contains metadata about the Deployment, such as its name.

`name`: `signup-page`: The name of the Deployment.
`spec`: Describes the desired state of the Deployment, including how many replicas of the application should be running and how to define the pods.

`replicas:` 1: Specifies that there should be one replica of the application running. Kubernetes will ensure that this many instances of the application are running at all times.

`selector`: Defines how the Deployment selects which pods to manage.

`matchLabels:` Specifies that the Deployment should manage pods with the label app: signup-page
template: Specifies the pod template that Kubernetes will use to create new pods.

`metadata`: Contains metadata for the pods created from this template.

`labels`: Specifies the labels to be applied to the pods. In this case, the label app: `signup-page` is applied.
`spec`: Specifies the specification for the containers within the pod.

`containers`: Describes the containers that should be run in the pod.

`name`: `signup-page-container`: The name of the container.

`image`: devoyinda/capstone_proj_6_doc_and_kub:1.0: Specifies the Docker image to use for the container. The image devoyinda/capstone_proj_6_doc_and_kub is being used with the 1.0 tag, indicating the version of the image - This is the image we pushed to the dockerhub.

`ports`: Specifies the ports to expose on the container.

`containerPort`: 80: Specifies that port 80 within the container should be exposed. This allows traffic to reach the application running inside the container.


2. Create Service YAML File - Write your Kubernetes Service configuration in a YAML file. This file exposes your application to network traffic.

```bash
touch kub-service.yaml
vim kub-service.yaml
```

![](./images/22.%20create%20service%20yaml%20file.png)


3. Apply the deployment and service to the cluster
```bash
kubectl apply -f kub-deployment.yaml
kubectl apply -f service.yaml
```

![](./images/23.%20apply%20the%20deployment%20to%20cluster.png)
![](./images/24.%20apply%20service%20to%20my%20cluster.png)

4. Verify Deployment and Service - After applying the YAML files, you can verify that the resources have been created successfully by running:
```bash
kubectl get deployments
kubectl get service
```

![](./images/25.%20verify%20deployment%20&%20services%20running.png)


## Step 7: Access the Application
## Task
1. Port forward the service to access the application locally.

Once you have identified the pod, you can use the kubectl port-forward command to forward a local port to a port on the pod.

`kubectl port-forward <pod-name> <local-port>:<pod-port>`

Replace `<pod-name>` with the name of your pod, `<local-port>` with the port on your local machine you want to use to access the application, and `<pod-port>` with the port your application is listening on within the pod.

```bash
kubectl port-forward service/signup-page-service 8080:80
```

![](./images/26.%20port%20forwarding.png)

2. Access the website through your browser on port 8080

In your browser, visit http://localhost:8080 to view your static website.

![](./images/27.%20view%20website.png)


# CONCLUSION
This project effectively demonstrated the power of containerization and orchestration in deploying a static web application. By containerizing the frontend with Docker, we encapsulated all necessary dependencies, ensuring consistent deployment across various environments. 
The integration of Kubernetes further highlighted its capabilities in container management, scaling, and deployment within a highly available cluster environment. The project emphasized the simplicity and efficiency of using Nginx as a web server, paired with Kubernetes as a robust platform for managing containerized workloads. Port-forwarding the Kubernetes service enabled local access to the deployed application, completing the full lifecycle of containerization and orchestration. The website is successfully containerized, deployed on Kubernetes, and accessible from a browser, demonstrating the end-to-end process of using Docker and Kubernetes for containerization and orchestration.

In conclusion, this capstone project provides a solid foundation for deploying web applications using modern technologies like Docker and Kubernetes—both of which are essential for scaling applications in today’s cloud-native environments.


### `TROUBLESHOOTING ISSUES`

Originally, in the service.yaml file, my type was cluster IP.

I wasn't able to view my website externally.
My configuration creates a ClusterIP service, which is only accessible from within the Kubernetes cluster. If I want to access this service externally (from an EC2 instance or any other location outside the cluster), I’ll need to change the type of the service to either NodePort or LoadBalancer.

- I changed mine from ClusterIP to `LoadBalancer`.

(Recommended for Cloud Environments)
If you’re running Kubernetes on a cloud provider like AWS, and your cluster supports load balancers, you can set the service type to LoadBalancer. This will automatically provision an external IP that you can use to access the service.

![](./images/28.%20using%20loadbalancer%20type.png)

- Check Security Group Settings
Ensured that the EC2 instance’s security group allows inbound traffic on the required port (e.g., 30007 for NodePort or `80 for LoadBalancer`). This step is essential to make the service accessible externally.

![](./images/29.%20check%20port%2080.png)

