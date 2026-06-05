pipeline {
    agent none

    environment {
        REPO_URL = 'https://github.com/lherbeng/RKE2.git'
        BASE_DIR = 'infra/rke2'

        INSTALL_SERVER_SCRIPT = "${BASE_DIR}/install-server.sh"
        UNINSTALL_SERVER_SCRIPT = "${BASE_DIR}/uninstall-server.sh"
        INSTALL_AGENT_SCRIPT = "${BASE_DIR}/install-agent.sh"
        UNINSTALL_AGENT_SCRIPT = "${BASE_DIR}/uninstall-agent.sh"
    }

    parameters {
        choice(
            name: 'NODE_TYPE',
            choices: ['server', 'agent'],
            description: 'Select node type to manage'
        )

        choice(
            name: 'ACTION',
            choices: ['install', 'uninstall'],
            description: 'Choose whether to install or uninstall RKE2'
        )
    }

    stages {

        stage('Install RKE2 Server') {
            when {
                allOf {
                    expression { params.NODE_TYPE == 'server' }
                    expression { params.ACTION == 'install' }
                }
            }

            agent { label 'agent1' }

            stages {

                stage('Checkout') {
                    steps {
                        git url: "${REPO_URL}", branch: 'main'
                    }
                }

                stage('Install Server') {
                    steps {
                        sh '''
                            set -e
                            chmod +x infra/rke2/install-server.sh
                            infra/rke2/install-server.sh
                        '''
                    }
                }

                stage('Verify Server') {
                    steps {
                        sh '''
                            set -e

                            export KUBECONFIG=/etc/rancher/rke2/rke2.yaml

                            # ensure kubectl path consistency
                            export PATH=$PATH:/usr/local/bin:/usr/bin

                            if command -v kubectl >/dev/null 2>&1; then
                                kubectl get nodes -o wide
                            else
                                echo "kubectl not found in PATH"
                                exit 1
                            fi
                        '''
                    }
                }
            }
        }

        stage('Uninstall RKE2 Server') {
            when {
                allOf {
                    expression { params.NODE_TYPE == 'server' }
                    expression { params.ACTION == 'uninstall' }
                }
            }

            agent { label 'agent1' }

            stages {

                stage('Checkout') {
                    steps {
                        git url: "${REPO_URL}", branch: 'main'
                    }
                }

                stage('Uninstall Server') {
                    steps {
                        sh '''
                            set -e
                            chmod +x infra/rke2/uninstall-server.sh
                            infra/rke2/uninstall-server.sh
                        '''
                    }
                }
            }
        }

        stage('Install RKE2 Agents Parallel') {
            when {
                allOf {
                    expression { params.NODE_TYPE == 'agent' }
                    expression { params.ACTION == 'install' }
                }
            }

            parallel {

                stage('Install Agent on workernode1') {
                    agent { label 'agent1' }

                    stages {
                        stage('Checkout') {
                            steps {
                                git url: "${REPO_URL}", branch: 'main'
                            }
                        }

                        stage('Install Agent1') {
                            steps {
                                sh '''
                                    set -e
                                    chmod +x infra/rke2/install-agent.sh
                                    infra/rke2/install-agent.sh
                                '''
                            }
                        }
                    }
                }

                stage('Install Agent on workernode2') {
                    agent { label 'agent2' }

                    stages {
                        stage('Checkout') {
                            steps {
                                git url: "${REPO_URL}", branch: 'main'
                            }
                        }

                        stage('Install Agent2') {
                            steps {
                                sh '''
                                    set -e
                                    chmod +x infra/rke2/install-agent.sh
                                    infra/rke2/install-agent.sh
                                '''
                            }
                        }
                    }
                }
            }
        }

        stage('Uninstall RKE2 Agents Parallel') {
            when {
                allOf {
                    expression { params.NODE_TYPE == 'agent' }
                    expression { params.ACTION == 'uninstall' }
                }
            }

            parallel {

                stage('Uninstall Agent on workernode1') {
                    agent { label 'agent1' }

                    stages {
                        stage('Checkout') {
                            steps {
                                git url: "${REPO_URL}", branch: 'main'
                            }
                        }

                        stage('Uninstall Agent1') {
                            steps {
                                sh '''
                                    set -e
                                    chmod +x infra/rke2/uninstall-agent.sh
                                    infra/rke2/uninstall-agent.sh
                                '''
                            }
                        }
                    }
                }

                stage('Uninstall Agent on workernode2') {
                    agent { label 'agent2' }

                    stages {
                        stage('Checkout') {
                            steps {
                                git url: "${REPO_URL}", branch: 'main'
                            }
                        }

                        stage('Uninstall Agent2') {
                            steps {
                                sh '''
                                    set -e
                                    chmod +x infra/rke2/uninstall-agent.sh
                                    infra/rke2/uninstall-agent.sh
                                '''
                            }
                        }
                    }
                }
            }
        }
    }

    post {
        success {
            echo "✅ ${params.NODE_TYPE} ${params.ACTION} completed successfully."
        }

        failure {
            echo "❌ ${params.NODE_TYPE} ${params.ACTION} failed."
        }
    }
}