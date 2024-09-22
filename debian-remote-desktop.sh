PROJECT_ID=$(gcloud config get-value project)
ZONE=$(gcloud config get-value compute/zone)
DEBIAN_IMAGE=$(gcloud compute images list --project=debian-cloud --filter="name~'debian-12' AND architecture='X86_64'" --sort-by="~creationTimestamp" --limit=1 --format="value(name)")

gcloud compute instances create emptydebianvm \
 --machine-type=n2-standard-4 \
 --network-interface=network-tier=PREMIUM,stack-type=IPV4_ONLY,subnet=default \
 --provisioning-model=SPOT \
 --scopes=https://www.googleapis.com/auth/devstorage.read_only,https://www.googleapis.com/auth/logging.write,https://www.googleapis.com/auth/monitoring.write,https://www.googleapis.com/auth/servicecontrol,https://www.googleapis.com/auth/service.management.readonly,https://www.googleapis.com/auth/trace.append \
 --create-disk=auto-delete=yes,boot=yes,device-name=emptydebian,image=projects/debian-cloud/global/images/$DEBIAN_IMAGE,mode=rw,size=20,type=projects/$PROJECT_ID/zones/$ZONE/diskTypes/pd-balanced \
 --no-shielded-secure-boot --shielded-vtpm \
 --tags emptydebianvm \
 --zone $ZONE \
 --enable-nested-virtualization \
 --instance-termination-action=stop \
 --can-ip-forward \
 --metadata serial-port-enable=TRUE \
 --metadata-from-file startup-script=emptydebian_v1_script.sh
