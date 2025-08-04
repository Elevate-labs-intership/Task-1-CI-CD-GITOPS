#Task-1 ci-cd-gitops

# ----------- Build Stage -----------
FROM node:slim AS build


RUN apt-get update && apt-get install -y git 

WORKDIR /usr/src/app

# Clone the private repo using forwarded SSH key


RUN  git clone https://github.com/Elevate-labs-intership/Task-1-CI-CD-GITOPS.git


# Install dependencies and build the project
WORKDIR /usr/src/app/Task-1-CI-CD-GITOPS
RUN npm install && npm run build


# ----------- Runtime Stage -----------
FROM node:slim

WORKDIR /usr/src/app/

# Copy built project from previous stage
COPY --from=build /usr/src/app/Task-1-CI-CD-GITOPS ./

# Start the app
CMD ["npm", "run","start"]