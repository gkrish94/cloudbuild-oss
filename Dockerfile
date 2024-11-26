#Stage 1: Install dependencies with credentials
FROM python:3.11-slim AS builder
WORKDIR /app
ARG ACCESS_TOKEN
ENV ACCESS_TOKEN=${ACCESS_TOKEN}
RUN echo $ACCESS_TOKEN
#keyrings 
RUN pip install keyring
RUN pip install keyrings.google-artifactregistry-auth
#Set up Python package dependencies, including GCP package if needed
#RUN pip install --upgrade pip setuptools wheel

#Configure pip to use the access token for the private repository
RUN pip install --extra-index-url https://${ACCESS_TOKEN}@us-central1-python.pkg.dev/challenger-oss/challengeross-python-repo/simple/ mypackage

#Stage 2: Copy dependencies to the final image
FROM python:3.11-slim
#Copy installed packages from the builder
COPY --from=builder /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
#Set the working directory
WORKDIR /app
RUN pip install flask
#copy the main.py 
COPY main.py /app
#run the flask server  
CMD [ "python3", "-m" , "flask","--app", "main.py", "run", "--host=0.0.0.0"]
