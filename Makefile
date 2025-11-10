# ---------- config ----------
ROOT      := $(HOME)/workspace/aws_sandbox
TF_DIR    := $(ROOT)
ANS_DIR   := $(ROOT)/ansible
ANS_INV   := $(ROOT)/inventory.ini
ANS_USER  := ubuntu
ANS_SSH   := $(HOME)/.ssh/sandbox
ANSFLAGS ?= # for now there isn't any

# ---------- terraform ----------
.PHONY: tf-init tf-fmt tf-validate tf-plan tf-apply tf-outputs tf-destroy
tf-init:
	@terraform -chdir=$(TF_DIR) init -input=false

tf-fmt:
	@terraform -chdir=$(TF_DIR) fmt -recursive

tf-validate:
	@terraform -chdir=$(TF_DIR) validate

tf-plan: tf-validate
	@terraform -chdir=$(TF_DIR) plan

tf-apply: tf-validate
	@terraform -chdir=$(TF_DIR) apply -auto-approve

tf-outputs:
	@terraform -chdir=$(TF_DIR) output

tf-destroy:
	@terraform -chdir=$(TF_DIR) destroy -auto-approve

# ---------- ansible ----------
.PHONY: ping bootstrap kubeadm helm ansible-all
ping:
	@ANSIBLE_HOST_KEY_CHECKING=False \
	ansible -i $(ANS_INV) all -m ping -u $(ANS_USER) --private-key $(ANS_SSH)

bootstrap:
	@ANSIBLE_HOST_KEY_CHECKING=False \
	ansible-playbook -i $(ANS_INV) $(ANS_DIR)/bootstrap.yml -u $(ANS_USER) --private-key $(ANS_SSH) $(ANSFLAGS)

kubeadm:
	@ANSIBLE_HOST_KEY_CHECKING=False \
	ansible-playbook -i $(ANS_INV) $(ANS_DIR)/kubeadm.yml -u $(ANS_USER) --private-key $(ANS_SSH) $(ANSFLAGS)

helm:
	@ANSIBLE_HOST_KEY_CHECKING=False \
	ansible-playbook -i $(ANS_INV) $(ANS_DIR)/helm.yml -u $(ANS_USER) --private-key $(ANS_SSH) $(ANSFLAGS)

ansible-all:
	@$(MAKE) bootstrap
	@$(MAKE) kubeadm
	@$(MAKE) helm

# ---------- orchestration ----------
.PHONY: up nuke
up:
	@$(MAKE) tf-init
	@$(MAKE) tf-fmt
	@$(MAKE) tf-validate
	@$(MAKE) tf-apply

install:
	@$(MAKE) ansible-all

nuke:
	@$(MAKE) tf-destroy
