# UnixProject
This is the final project for our Unix class:

# Project Description

The goal of this project is to set up a system that connects multiple machines together, allowing for monitoring of their system processes such as CPU, GPU, 
and memory usage. This addresses the real-world issue of providing system administrators with a way to monitor the health of Linux machines connected to a 
central server. Such monitoring is essential for identifying servers with abnormally high resource usage.

---

## Platform of Choice

The monitoring system will be implemented on virtual machines (VMs) running GNU/Linux. A central server will act as the hub, communicating with other VMs 
through a simulated network. These VMs will emulate a production environment, enabling testing of the system's monitoring capabilities.

---

## Demonstration Plan

The project will be demonstrated on a laptop with sufficient resources to run multiple VMs using VMware or VirtualBox. A virtualized network will simulate a 
local network setup, enabling the monitoring server to collect data from other VMs.

---

## Requirements

### Basic System and Security Setup
- **User Accounts:** Create user accounts with varied permission levels to maintain a secure environment.
- **File Permissions:** Use `chmod` to restrict access to log and configuration files associated with monitoring.
- **Service Management:** Use `systemd` to manage monitoring tools by starting, stopping, and restarting monitoring agents as needed.

### Process or Service Management/Scheduling
- **Automating Tasks with Systemd:** Automate running a script every five minutes to check CPU usage.
- **Script Automation:**
  - Automatic Alerts/Emails: Trigger a warning and send an email if CPU usage exceeds a threshold.

---

## Major Technical Solutions Compared

The project involves evaluating multiple system monitoring software to identify the best option. The tools considered are:
- **Prometheus with Grafana**
- **Checkmk**
- **Zabbix**

Each tool will be assessed based on:
- Installation complexity
- Visual interface usability
- Ease of use
- Features offered

The most suitable tool will be selected and implemented in the project.

---

## Timeline

### Week 1: Tool Exploration and Analysis
- **Tool Exploration:** Each team member researches Zabbix, Prometheus with Grafana, and CheckMk.
- **Installation and Configuration Analysis:** Document installation and setup for each tool, focusing on ease of use, complexity, and requirements.
- **Comparative Analysis:** Share findings and compare each tool's features, usability, and compatibility with project goals.

### Week 2: Tool Selection and VM Setup
- **Tool Selection:** Choose the monitoring tool based on Week 1 findings.
- **Server and VM Setup:** Configure the monitoring server on one VM and connect it to other VMs.
- **Network Simulation:** Create a virtualized network for data transfer between the server and VMs.
- **Process Simulation:** Set up programs on VMs to simulate high resource usage for CPU, RAM, and disk space.
- **Initial Testing:** Verify successful data transmission (CPU, GPU, memory) from VMs to the server.

### Week 3: Automation and Finalization
- **Automation Scripting:** Develop shell scripts to automate tasks like disk usage checks, process monitoring, and system performance updates.
- **Scheduling with Cron Jobs:** Use Cron jobs for periodic data collection, backup, and reporting.
- **Final Testing and Debugging:** Ensure seamless integration and real-time data updates.
- **Project Presentation Preparation:** Set up the demonstration environment and prepare materials to highlight the project’s features and findings.

---

