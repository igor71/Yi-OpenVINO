pipeline {
  agent {label 'yi-openvino'}
    stages {
        stage('Build Docker Image') {
            steps {
                sh '''#!/bin/bash -xe
                docker build  -f Dockerfile-OpenVINO-1.144 -t yi/openvino:1.144 .
		            ''' 
            }
        }
	    stage('Test Docker Image') { 
            steps {
                sh '''#!/bin/bash -xe
		            echo 'Hello, OpenVINO_Docker'
                    image_id="$(docker images -q yi/openvino:1.144)"
                      if [[ "$(docker images -q yi/openvino:1.144 2> /dev/null)" == "$image_id" ]]; then
                          docker inspect --format='{{range $p, $conf := .RootFS.Layers}} {{$p}} {{end}}' $image_id
                      else
                          echo "It appears that current docker image corrapted!!!"
                          exit 1
                      fi 
                   ''' 
		    }
		}
		stage('Save & Load Docker Image') { 
            steps {
                sh '''#!/bin/bash -xe
		        echo 'Saving Docker image into tar archive'
                docker save yi/openvino:1.144 | pv | cat > $WORKSPACE/yi-openvino-1.144.tar
			
                echo 'Remove Original Docker Image' 
			    CURRENT_ID=$(docker images | grep -E '^yi/openvino.*'1.144'' | awk -e '{print $3}')
			    docker rmi -f yi/openvino:1.144
			
                echo 'Loading Docker Image'
                pv -f $WORKSPACE/yi-openvino-1.144.tar | docker load
			    docker tag $CURRENT_ID yi/openvino:1.144 
                        
                echo 'Removing temp archive.'  
                rm $WORKSPACE/yi-openvino-1.144.tar
                   ''' 
		    }
		}
    }
	post {
            always {
               script {
                  if (currentBuild.result == null) {
                     currentBuild.result = 'SUCCESS' 
                  }
               }
               step([$class: 'Mailer',
                     notifyEveryUnstableBuild: true,
                     recipients: "igor.rabkin@xiaoyi.com",
                     sendToIndividuals: true])
            }
         } 
}