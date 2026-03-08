function devops
    set -g DEVOPS 1
end

function cluster --argument-names name
    printf '\033[3m\033[1;30m%s\033[0m\n' "kubectl config set-context --current --cluster=$name"
    kubectl config set-context --current --cluster="$name"

    set -g K8S_CLUSTER $name
end

function ns --argument-names name
    printf '\033[3m\033[1;30m%s\033[0m\n' "kubectl config set-context --current --namespace=$name"
    kubectl config set-context --current --namespace="$name"

    set -g K8S_NAMESPACE $name
end

function pod --argument-names name
    set -g K8S_POD $name
end

function k8s_help --argument-names clusters namespaces pods other
    set -f yellow "\033[1;33m"
    set -f blue "\033[1;34m"
    set -f white "\033[1;37m"
    set -f nc "\033[0m"

    printf "┌─────────────────────────────────────────────────┐\n"

    if test $clusters -eq 1
        printf "│ \033[1;33m%s\033[0m                                        │\n" "Clusters"
        printf "│   clusters   list clusters                      │\n"
        printf "│   cluster    select a cluster                   │\n"
        printf "│                                                 │\n"
    end

    if test $namespaces -eq 1
        printf "│ \033[1;33m%s\033[0m                                      │\n" "Namespaces"
        printf "│   namespaces list namespaces                    │\n"
        printf "│   ns         select a namespace                 │\n"
        printf "│                                                 │\n"
    end

    if test $pods -eq 1
        printf "│ \033[1;33m%s\033[0m                                            │\n" "Pods"
        printf "│   pods        list pods                         │\n"
        printf "│   pod         select a pod                      │\n"
        printf "│                                                 │\n"
    end

    if test $other -eq 1
        printf "│ \033[1;33m%s\033[0m                                           │\n" "Other"
        printf "│   logs        get logs for the current context  │\n"
        printf "│   shell       open a shell                      │\n"
        printf "│   kenv        get environment variables         │\n"
        printf "│                                                 │\n"
    end

    printf "└─────────────────────────────────────────────────┘\n\n"
end

function k8s
    set -f black "\033[1;30m"
    set -f nc "\033[0m"

    if not set -q K8S_CLUSTER
        k8s_help 1 0 0 0
    else if not set -q K8S_NAMESPACE
        k8s_help 0 1 0 0

        printf '\033[3m\033[1;30m%s\033[0m\n' "kubectl get namespaces"
        kubectl get namespaces
    else if not set -q K8S_POD
        k8s_help 0 0 1 0

        printf '\033[3m\033[1;30m%s\033[0m\n' "kubectl get pods"
        kubectl get pods
    else
        k8s_help 1 1 1 1
    end
end
