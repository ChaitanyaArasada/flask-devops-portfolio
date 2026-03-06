# flask-devops-portfolio 
Project Overview

This project demonstrates the process of building, containerizing, and optimizing a Python web application using modern DevOps practices. The application itself is a minimal portfolio website built with Flask, designed to serve as a simple web interface while focusing primarily on the infrastructure and containerization workflow behind it. The goal of this project was not just to build a web application, but to understand how applications are packaged, optimized, and prepared for deployment in real-world cloud environments.

As part of this learning exercise, the Flask application was first developed and tested locally. After verifying that the application worked correctly, it was containerized using Docker. Containerization allows the application and its dependencies to be packaged together into a portable environment, ensuring that the application runs consistently across development, testing, and production systems. The containerized application uses Gunicorn as the production WSGI server, enabling the Flask application to run in a production-ready configuration rather than relying on Flask’s development server.

After successfully building the initial Docker image, the container was pushed to Docker Hub so that it could be stored in a container registry and pulled from any environment. Publishing images to a registry is a common step in modern DevOps workflows because it enables teams to distribute application images across deployment environments such as staging servers, Kubernetes clusters, or cloud container platforms.

Once the basic containerization process was complete, the project moved into the optimization phase. A multi-stage Docker build strategy was implemented to separate the build environment from the final runtime environment. In the first stage, the application dependencies are installed and prepared using a Python base image. In the final stage, only the necessary runtime components and application files are copied into a much smaller runtime container. This approach helps eliminate unnecessary build tools, intermediate files, and system utilities from the final container image.

To further optimize the container, the runtime image was replaced with a distroless container. Distroless images contain only the minimal runtime components required to run an application and intentionally exclude package managers, shells, and other operating system utilities. This significantly reduces the size of the container image while also decreasing the attack surface of the runtime environment. As a result of implementing multi-stage builds and distroless images, the final container size was reduced from approximately 250 MB to 155 MB, achieving a reduction of roughly 38 percent.

Overall, this project demonstrates several important DevOps concepts including application containerization, image optimization, secure runtime environments, and container registry publishing. These practices are commonly used in modern cloud-native architectures and form the foundation for deploying applications to platforms such as Kubernetes or cloud container services.

## project structure
~~~
flask-devops-portfolio/
│
├── app.py
├── requirements.txt
├── Dockerfile
│
├── templates/
│   └── portfolio.html
│
├── static/
│   └── style.css
│
└── README.md
~~~


The app.py file contains the core logic of the application built using Flask. It defines the Flask application instance and the route that renders the portfolio webpage. The application uses Flask’s template rendering system to serve an HTML page stored inside the templates directory.

The requirements.txt file contains all the Python dependencies required for the application to run. When the application is built inside a container, these dependencies are automatically installed so that the application environment remains consistent across different systems.

The templates directory contains the HTML files used by Flask’s templating engine. In this project, the portfolio.html file represents the main portfolio webpage that is rendered when users access the root endpoint of the application.

The static directory contains static resources such as CSS files. The style.css file is responsible for styling the portfolio page and improving the visual appearance of the application interface.

The Dockerfile defines how the application is packaged into a container image using Docker. It specifies the base image, working directory, dependency installation steps, and the command used to run the application.


Step 1 — Building the Flask Application

The first step in this project was to develop a simple web application using Flask. The purpose of this application is to serve a personal DevOps portfolio page through a web browser. Flask was chosen because it is lightweight and widely used for building Python web applications.

Inside the app.py file, the Flask application instance is created and a route is defined to render the portfolio page. The application listens on 0.0.0.0 and port 5000 so that it can accept external connections when running inside a container environment.

efore containerizing the application, the dependencies were installed locally using the following command:
```
pip install -r requirements.txt
```
Once the dependencies were installed, the application was executed locally using:
```
python app.py
```
The application could then be accessed in a web browser at:
```
http://localhost:5000
```
Running the application locally ensured that everything worked correctly before moving to the containerization stage.


Step 2 — Containerizing the Application

After verifying that the Flask application worked correctly, the next step was to containerize it using Docker. Containerization allows the application and all its dependencies to be packaged together into a portable environment that can run consistently on any system.

A Dockerfile was created to define how the container image should be built. The base image used for this container was the lightweight Python runtime image:
```
python:3.11-slim
```
The Dockerfile installs the required Python dependencies, copies the application files into the container, and runs the application using Gunicorn, which is commonly used to run Flask applications in production environments.

The Docker image was built using the command:
```
docker build -t flask-devops-portfolio .
```
Once the image was successfully created, the container was started using:
```
docker run -p 5000:5000 flask-devops-portfolio
```
This command maps the container port to the host machine so the application can be accessed through a browser.

The application was then available at:
```
http://localhost:5000
```
At this stage, the container image size was approximately 250 MB.


Step 3 — Publishing the Image to Docker Hub

After successfully building and testing the Docker image locally, the next step was to publish the image to a container registry. Container registries allow images to be stored centrally so they can be pulled and deployed from anywhere.

The image was pushed to Docker Hub by first authenticating with the registry:
```
docker login
```
Next, the image was tagged with the Docker Hub repository name:
```
docker tag flask-devops-portfolio <dockerhub-username>/flask-devops-portfolio:latest
```
Finally, the image was uploaded to Docker Hub using:
```
docker push <dockerhub-username>/flask-devops-portfolio:latest
```
Once the image is available in Docker Hub, it can be pulled from any environment using the docker pull command. This is an essential step in modern DevOps workflows because it allows application images to be distributed to different deployment environments.

Step 4 — Implementing Multi-Stage Docker Builds

Although the initial container worked correctly, the image contained unnecessary build dependencies that increased its size. To improve efficiency and follow production best practices, a multi-stage Docker build was implemented.

In a multi-stage build process, the container build is divided into separate stages. The first stage is responsible for installing dependencies and preparing the application environment. The second stage creates the final runtime image by copying only the required files from the builder stage.

This approach helps remove build tools, temporary files, and unnecessary dependencies from the final image. As a result, the runtime container becomes smaller, cleaner, and more efficient.

Step 5 — Optimizing the Container with Distroless Images

To further optimize the container, the runtime stage of the Docker build was replaced with a distroless image. Distroless images contain only the minimal runtime components required to execute an application.

Unlike traditional container images, distroless containers do not include shells, package managers, or unnecessary operating system utilities. This significantly reduces the container size and improves security by minimizing the attack surface.

By combining multi-stage builds with distroless runtime images, the final container became significantly smaller and more efficient.

Image Size Comparison

After optimization, the container image size was reduced from approximately 250 MB to 155 MB, resulting in a reduction of nearly 38 percent. This improvement leads to faster deployments, reduced storage usage, and improved performance when pulling images from container registries.

Running the Optimized Container

The optimized container image can be built using:
```
docker build -t flask-devops-distroless .
```
Once the build is complete, the container can be started using:
```
docker run -p 5000:5000 flask-devops-distroless
```
The optimized application remains accessible through the browser at:
```
http://localhost:5000
```
Conclusion

Through this project, a simple Python web application was taken through the complete DevOps workflow. The process began with building the application locally, followed by containerizing it using Docker, publishing the image to Docker Hub, and finally optimizing the container using multi-stage builds and distroless runtime images.

This workflow demonstrates important real-world DevOps practices such as containerization, image optimization, secure runtime environments, and container registry publishing. These concepts form the foundation for deploying scalable applications in modern cloud-native platforms.


<img width="1920" height="1080" alt="Screenshot (213)" src="https://github.com/user-attachments/assets/deaec8e4-4e43-4962-b1f8-5c7a34f9d141" />

<img width="1920" height="1080" alt="Screenshot (215)" src="https://github.com/user-attachments/assets/87a37287-78c3-4e3b-88f1-2b1e6cd39345" />

<img width="1920" height="1024" alt="Screenshot (220)" src="https://github.com/user-attachments/assets/16cc42d8-4e19-4cca-823b-698092950333" />

<img width="1920" height="1080" alt="Screenshot (218)" src="https://github.com/user-attachments/assets/00f2eb85-9eb2-4dc5-af5b-9061c47ef612" />

<img width="1920" height="1031" alt="Screenshot (219)" src="https://github.com/user-attachments/assets/bb43468d-3c65-4286-9e7d-97526cd78296" />



<img width="1920" height="1042" alt="Screenshot (209)" src="https://github.com/user-attachments/assets/5dec6f4e-34a9-46c6-89f2-623ae223a84c" />


