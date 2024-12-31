import requests
import socket
import ssl
import sys
import time
from datetime import datetime

def check_dns_propagation(domain):
    github_ips = [
        "185.199.108.153",
        "185.199.109.153",
        "185.199.110.153",
        "185.199.111.153"
    ]
    
    try:
        ip = socket.gethostbyname(domain)
        print(f"\n{datetime.now()}")
        print(f"DNS Resolution: {domain} -> {ip}")
        
        if ip in github_ips:
            print("✅ DNS has propagated to GitHub Pages IPs")
            return True
        else:
            print("⏳ DNS still pointing to old IP, waiting for propagation...")
            print(f"Current IP: {ip}")
            print(f"Expected one of: {github_ips}")
            return False
            
    except socket.gaierror as e:
        print(f"❌ DNS lookup failed: {e}")
        return False

def check_github_deployment(domain):
    urls = [
        f"https://{domain}",
        f"https://www.{domain}"
    ]
    
    for url in urls:
        try:
            response = requests.get(url, timeout=10)
            print(f"\nTesting {url}:")
            print(f"✅ Status Code: {response.status_code}")
            
            # Check if served from GitHub Pages
            if "GitHub.com" in response.headers.get('server', ''):
                print("✅ Served from GitHub Pages")
                return True
            else:
                print("⏳ Not yet served from GitHub Pages")
                return False
                
        except requests.exceptions.SSLError:
            print(f"⏳ SSL not yet ready for {url}")
            return False
        except requests.exceptions.RequestException as e:
            print(f"❌ Request failed: {str(e)}")
            return False
    
    return False

def main():
    domain = "natrajinfo.in"
    print(f"Starting complete deployment check for {domain}")
    print("Press Ctrl+C to stop checking")
    
    try:
        while True:
            dns_ready = check_dns_propagation(domain)
            if dns_ready:
                github_ready = check_github_deployment(domain)
                if github_ready:
                    print("\n✅ Site is fully deployed and served from GitHub Pages!")
                    print("✅ HTTPS is working")
                    print("✅ All checks passed")
                    break
            time.sleep(300)  # Check every 5 minutes
            
    except KeyboardInterrupt:
        print("\nStopped checking deployment")

if __name__ == "__main__":
    main() 