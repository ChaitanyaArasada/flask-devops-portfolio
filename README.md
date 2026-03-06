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

