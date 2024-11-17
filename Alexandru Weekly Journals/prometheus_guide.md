
# Prometheus and Grafana Installation Step-by-Step Guide

## 1. Installing Prometheus and Node Explorer [resource](https://www.howtoforge.com/how-to-install-prometheus-and-node-exporter-on-debian-12/)

1. Running the command : `sudo apt install prometheus prometheus-node-exporter` will install both of them and will automatically run each service on their default ports. (Prometheus: `9090` & Node Explorer: `9100`)
2. You can configure the `prometheus.yml` folder by editing the file with the editor of your choosing. The default file location is at `/etc/prometheus/prometheus.yml`
3. You can add another prometheus `IP:PORT#` to the `-target:[]` array under `- job_name: "prometheus"`
4. You can add another node  `IP:PORT#` to the `-target:[]` array under `- job_name: "prometheus-node-explorer"`
5. Restart the service by running `sudo systemctl restart prometheus`

## 2. Installing Grafana [resource](https://grafana.com/docs/grafana/latest/setup-grafana/installation/debian/)

1. Install the prerequisite package : `sudo apt-get install -y apt-transport-https software-properties-common wget`
2. Import the GPG Key: `sudo mkdir -p /etc/apt/keyrings/ wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | sudo tee /etc/apt/keyrings/grafana.gpg > /dev/null`
3. Install Grafana OSS: `sudo apt-get install grafana` This will also run on its own on its default port `3000`

## 3. Adding the data sources to Grafana

1. In the menu on the left, under the connection tab, you will select Data Sources
2. Click add new data source and select the Prometheus option
3. Give that data source the `IP:PORT#` of your prometheus client

## 4. Adding dashboards

1. In the menu on the left, select the Dashboards tab
2. When creating a new dashboard you can select import to import a public dashboard.

