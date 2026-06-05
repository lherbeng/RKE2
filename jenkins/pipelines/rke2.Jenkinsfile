pipeline {
    agent none

    environment {
        REPO_URL = 'https://github.com/lherbeng/RKE2.git'
        BASE_DIR = 'infra/rke2'

        INSTALL_SERVER_SCRIPT = "${BASE_DIR}/install-server.sh"
        UNINSTALL_SERVER_SCRIPT = "${BASE_DIR}/uninstall-server.sh"
        INSTALL_AGENT_SCRIPT = "${BASE_DIR}/install-agent.sh"
        UNINSTALL_AGENT_SCRIPT = "${BASE_DIR}/uninstall-agent.sh"
        KUBECONFIG_SCRIPT = "${BASE_DIR}/kubeconfig.sh"

        // ✅ FIX #1: global kubeconfig for all kubectl commands
        KUBECONFIG = "/home/jenkins/.kube/config"
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
                        echo 'Installing RKE2 Server...'

                        sh """
                            chmod +x ${INSTALL_SERVER_SCRIPT}
                            bash ${INSTALL_SERVER_SCRIPT}
                        """
                    }
                }

                stage('Verify Server + Fix Kubeconfig') {
                    steps {
                        echo 'Fixing kubeconfig for Jenkins access...'

                        sh """
                            chmod +x ${KUBECONFIG_SCRIPT}
                            bash ${KUBECONFIG_SCRIPT}
                        """

                        // ✅ FIX #2: ensure kubeconfig is usable (no export needed)
                        sh """
                            mkdir -p /home/jenkins/.kube
                            sudo cp /etc/rancher/rke2/rke2.yaml /home/jenkins/.kube/config
                            sudo chown jenkins:jenkins /home/jenkins/.kube/config
                            chmod 600 /home/jenkins/.kube/config
                        """

                        // optional verification
                        sh """
                            kubectl get nodes || true
                        """
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
                        echo 'Uninstalling RKE2 Server...'

                        sh """
                            chmod +x ${UNINSTALL_SERVER_SCRIPT}
                            bash ${UNINSTALL_SERVER_SCRIPT}
                        """
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
                                echo 'Installing RKE2 Agent on workernode1...'

                                sh """
                                    chmod +x ${INSTALL_AGENT_SCRIPT}
                                    bash ${INSTALL_AGENT_SCRIPT}
                                """
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
                                echo 'Installing RKE2 Agent on workernode2...'

                                sh """
                                    chmod +x ${INSTALL_AGENT_SCRIPT}
                                    bash ${INSTALL_AGENT_SCRIPT}
                                """
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
                                echo 'Uninstalling RKE2 Agent from workernode1...'

                                sh """
                                    chmod +x ${UNINSTALL_AGENT_SCRIPT}
                                    bash ${UNINSTALL_AGENT_SCRIPT}
                                """
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
                                echo 'Uninstalling RKE2 Agent from workernode2...'

                                sh """
                                    chmod +x ${UNINSTALL_AGENT_SCRIPT}
                                    bash ${UNINSTALL_AGENT_SCRIPT}
                                """
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