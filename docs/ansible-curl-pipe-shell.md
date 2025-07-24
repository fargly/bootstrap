# Ansible Style 'curl|sh'

While it's technically possible to do `curl | sh` in Ansible, it's generally **not a recommended or good pattern** for several reasons, primarily related to security, idempotence, and maintainability.

### Why `curl | sh` is problematic:

1.  **Security Risk:**

      * You are executing arbitrary code downloaded from the internet without prior inspection. The script could be malicious, or the download source could be compromised.
      * There's no validation of the script's content before execution.
      * It's a common attack vector (e.g., supply chain attacks).

2.  **Lack of Idempotence:**

      * Ansible's strength lies in its idempotence – running a playbook multiple times should result in the same state without unintended side effects. A `curl | sh` command often doesn't guarantee idempotence. The script might install software repeatedly, overwrite configurations, or perform actions that aren't designed to be run more than once.
      * Ansible won't know if the script actually changed anything, leading to misleading "changed" states.

3.  **Debugging and Error Handling:**

      * Debugging issues within a script piped from `curl` can be very difficult. Ansible's error reporting will be limited to the `shell` module's output, not granular details about what failed inside the script.
      * There's no easy way to roll back changes made by the script if something goes wrong.

4.  **Maintainability and Readability:**

      * The logic of what's being installed or configured is hidden within an external script, making your Ansible playbooks less transparent and harder to understand for others (or your future self).
      * Updates to the external script can silently break your automation.

### Better Ansible Patterns and Alternatives:

Instead of `curl | sh`, aim for patterns that leverage Ansible's modules for secure, idempotent, and transparent automation.

1.  **Use `ansible.builtin.get_url` to download, then `ansible.builtin.shell` or `ansible.builtin.command` to execute (with caution):**
    This is a significant improvement because it allows you to inspect the script before execution.

    ```yaml
    - name: Download installation script
      ansible.builtin.get_url:
        url: https://example.com/install.sh
        dest: /tmp/install.sh
        mode: '0755' # Make it executable

    - name: Execute installation script
      ansible.builtin.shell: /tmp/install.sh -s -- -y # Add any necessary flags for non-interactive execution
      args:
        creates: /path/to/expected/file # Makes the task idempotent
                                        # (only runs if this file doesn't exist)
    ```

    **Still, be cautious with this approach.** Even after downloading, the script might not be idempotent. Always check the script's content and understand its behavior.

2.  **Use specific Ansible modules:**
    This is the **most recommended** approach. Ansible has a rich collection of modules for common tasks like package installation, file management, service control, and more. This ensures idempotence, proper error handling, and clear state management.

      * **Package Management:** For installing software from repositories.

        ```yaml
        - name: Install Nginx
          ansible.builtin.apt:
            name: nginx
            state: present
          when: ansible_os_family == "Debian"

        - name: Install Apache
          ansible.builtin.yum:
            name: httpd
            state: present
          when: ansible_os_family == "RedHat"
        ```

      * **File Transfer:** For copying local files to remote hosts.

        ```yaml
        - name: Copy custom configuration file
          ansible.builtin.copy:
            src: files/my_app.conf
            dest: /etc/my_app/my_app.conf
            owner: root
            group: root
            mode: '0644'
        ```

      * **Git Module:** For cloning repositories.

        ```yaml
        - name: Clone application repository
          ansible.builtin.git:
            repo: 'https://github.com/my-org/my-app.git'
            dest: /opt/my-app
            version: main # Or a specific tag/commit
            update: yes
        ```

      * **URI Module:** For interacting with web services (e.g., downloading binaries directly without running a shell script).

        ```yaml
        - name: Download application binary
          ansible.builtin.uri:
            url: https://example.com/app/v1.0/app-linux-x64.tar.gz
            dest: /tmp/app-linux-x64.tar.gz
            validate_certs: yes # Always validate certificates!
        ```

      * **Unarchive Module:** For extracting archives.

        ```yaml
        - name: Extract application
          ansible.builtin.unarchive:
            src: /tmp/app-linux-x64.tar.gz
            dest: /opt/
            remote_src: yes
        ```

3.  **Create Custom Modules or Roles:**
    If a specific task doesn't have a direct Ansible module, consider writing a custom module or a reusable role that encapsulates the logic securely and idempotently.

### When `shell` is (sometimes) acceptable (with `creates`/`removes`):

While generally discouraged for complex installations, the `ansible.builtin.shell` module can be used for very simple, one-off commands where no dedicated module exists, *especially* when combined with `creates` or `removes` to ensure idempotence.

```yaml
- name: Run a simple command if a file doesn't exist
  ansible.builtin.shell: echo "Hello, world!" > /tmp/hello.txt
  args:
    creates: /tmp/hello.txt # This task will only run if /tmp/hello.txt doesn't exist
```

In summary, avoid `curl | sh` in Ansible. Prioritize using built-in modules, and if absolutely necessary, download the script first with `get_url` and then execute it with `shell`, ensuring to implement idempotence checks and thoroughly review the script's contents.



