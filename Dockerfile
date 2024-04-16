FROM quay.io/ncross/hacbs-jvm-build-request-processor:dev AS build-request-processor
FROM quay.io/ncross/hacbs-jvm-cache:dev AS cache
FROM quay.io/ncross/artifact-deployments:a9f6c1c5855330eb8954af29247fbd8d-pre-build-image
USER 0
WORKDIR /root
ENV CACHE_URL=http://localhost:8080/v2/cache/rebuild-central/1696167059000/
RUN mkdir -p /root/project /root/software/settings /original-content/marker && microdnf install vim curl procps-ng bash-completion
COPY --from=build-request-processor /deployments/ /root/software/build-request-processor
COPY --from=build-request-processor /lib/jvm/jre-17 /root/software/system-java
COPY --from=build-request-processor /etc/java/java-17-openjdk /etc/java/java-17-openjdk
COPY --from=cache /deployments/ /root/software/cache
# RUN echo "Cloning https://github.com/apache/commons-net.git" && git clone https://github.com/apache/commons-net.git /root/project/workspace && cd /root/project/workspace && git reset --hard c3f36eb9078971a159a93065389983fd60ee95f6 && git submodule init && git submodule update --recursive
RUN echo IyEvYmluL3NoCi9yb290L3NvZnR3YXJlL3N5c3RlbS1qYXZhL2Jpbi9qYXZhIC1EYnVpbGQtcG9saWN5LmRlZmF1bHQuc3RvcmUtbGlzdD1yZWJ1aWx0LGNlbnRyYWwsamJvc3MscmVkaGF0IC1Ea3ViZS5kaXNhYmxlZD10cnVlIC1EcXVhcmt1cy5rdWJlcm5ldGVzLWNsaWVudC50cnVzdC1jZXJ0cz10cnVlIC1qYXIgL3Jvb3Qvc29mdHdhcmUvY2FjaGUvcXVhcmt1cy1ydW4uamFyID4vcm9vdC9jYWNoZS5sb2cgJgp3aGlsZSAhIGNhdCAvcm9vdC9jYWNoZS5sb2cgfCBncmVwICdMaXN0ZW5pbmcgb246JzsgZG8KICAgICAgICBlY2hvICJXYWl0aW5nIGZvciBDYWNoZSB0byBzdGFydCIKICAgICAgICBzbGVlcCAxCmRvbmUgCg== | base64 -d >/root/start-cache.sh
RUN echo IyEvYmluL3NoCi9yb290L3NvZnR3YXJlL3N5c3RlbS1qYXZhL2Jpbi9qYXZhIC1qYXIgL3Jvb3Qvc29mdHdhcmUvYnVpbGQtcmVxdWVzdC1wcm9jZXNzb3IvcXVhcmt1cy1ydW4uamFyIG1hdmVuLXByZXBhcmUgL3Jvb3QvcHJvamVjdC93b3Jrc3BhY2UgLWRwIG9yZy5nbGFzc2Zpc2guY29weXJpZ2h0OmdsYXNzZmlzaC1jb3B5cmlnaHQtbWF2ZW4tcGx1Z2luIC1kcCBvcmcuc29uYXR5cGUucGx1Z2luczpuZXh1cy1zdGFnaW5nLW1hdmVuLXBsdWdpbiAtZHAgY29tLm15Y2lsYTpsaWNlbnNlLW1hdmVuLXBsdWdpbiAtZHAgb3JnLmNvZGVoYXVzLm1vam86ZmluZGJ1Z3MtbWF2ZW4tcGx1Z2luIC1kcCBkZS5qam9oYW5uZXM6Z3JhZGxlLW1vZHVsZS1tZXRhZGF0YS1tYXZlbi1wbHVnaW4gLWRwIG9yZy5jb2RlaGF1cy5tb2pvOmNvYmVydHVyYS1tYXZlbi1wbHVnaW4gLWRwIGNvbS5kaWZmcGx1Zy5zcG90bGVzczpzcG90bGVzcy1tYXZlbi1wbHVnaW4gLWRwIGlvLmZhYnJpYzg6ZG9ja2VyLW1hdmVuLXBsdWdpbiAtZHAgb3JnLmFwYWNoZS5yYXQ6YXBhY2hlLXJhdC1wbHVnaW4K | base64 -d >/root/preprocessor.sh
RUN echo IyEvdXNyL2Jpbi9lbnYgYmFzaApzZXQgLW8gdmVyYm9zZQpzZXQgLWV1CnNldCAtbyBwaXBlZmFpbApGSUxFPSIkSkFWQV9IT01FL2xpYi9zZWN1cml0eS9jYWNlcnRzIgppZiBbICEgLWYgIiRGSUxFIiBdOyB0aGVuCiAgICBGSUxFPSIkSkFWQV9IT01FL2pyZS9saWIvc2VjdXJpdHkvY2FjZXJ0cyIKZmkKCmlmIFsgLWYgL3Jvb3QvcHJvamVjdC90bHMvc2VydmljZS1jYS5jcnQvc2VydmljZS1jYS5jcnQgXTsgdGhlbgogICAga2V5dG9vbCAtaW1wb3J0IC1hbGlhcyBqYnMtY2FjaGUtY2VydGlmaWNhdGUgLWtleXN0b3JlICIkRklMRSIgLWZpbGUgL3Jvb3QvcHJvamVjdC90bHMvc2VydmljZS1jYS5jcnQvc2VydmljZS1jYS5jcnQgLXN0b3JlcGFzcyBjaGFuZ2VpdCAtbm9wcm9tcHQKZmkKCgoKIyEvdXNyL2Jpbi9lbnYgYmFzaApzZXQgLW8gdmVyYm9zZQpzZXQgLWV1CnNldCAtbyBwaXBlZmFpbAoKY3AgLXIgLWEgIC9vcmlnaW5hbC1jb250ZW50LyogL3Jvb3QvcHJvamVjdApjZCAvcm9vdC9wcm9qZWN0L3dvcmtzcGFjZQoKaWYgWyAtbiAiIiBdCnRoZW4KICAgIGNkIApmaQoKaWYgWyAhIC16ICR7SkFWQV9IT01FK3h9IF07IHRoZW4KICAgIGVjaG8gIkpBVkFfSE9NRTokSkFWQV9IT01FIgogICAgUEFUSD0iJHtKQVZBX0hPTUV9L2JpbjokUEFUSCIKZmkKCmlmIFsgISAteiAke01BVkVOX0hPTUUreH0gXTsgdGhlbgogICAgZWNobyAiTUFWRU5fSE9NRTokTUFWRU5fSE9NRSIKICAgIFBBVEg9IiR7TUFWRU5fSE9NRX0vYmluOiRQQVRIIgpmaQoKaWYgWyAhIC16ICR7R1JBRExFX0hPTUUreH0gXTsgdGhlbgogICAgZWNobyAiR1JBRExFX0hPTUU6JEdSQURMRV9IT01FIgogICAgUEFUSD0iJHtHUkFETEVfSE9NRX0vYmluOiRQQVRIIgpmaQoKaWYgWyAhIC16ICR7QU5UX0hPTUUreH0gXTsgdGhlbgogICAgZWNobyAiQU5UX0hPTUU6JEFOVF9IT01FIgogICAgUEFUSD0iJHtBTlRfSE9NRX0vYmluOiRQQVRIIgpmaQoKaWYgWyAhIC16ICR7U0JUX0RJU1QreH0gXTsgdGhlbgogICAgZWNobyAiU0JUX0RJU1Q6JFNCVF9ESVNUIgogICAgUEFUSD0iJHtTQlRfRElTVH0vYmluOiRQQVRIIgpmaQplY2hvICJQQVRIOiRQQVRIIgoKI2ZpeCB0aGlzIHdoZW4gd2Ugbm8gbG9uZ2VyIG5lZWQgdG8gcnVuIGFzIHJvb3QKZXhwb3J0IEhPTUU9L3Jvb3QKCm1rZGlyIC1wIC9yb290L3Byb2plY3QvbG9ncyAvcm9vdC9wcm9qZWN0L3BhY2thZ2VzIC9yb290L3Byb2plY3QvYnVpbGQtaW5mbwoKCgojVGhpcyBpcyByZXBsYWNlZCB3aGVuIHRoZSB0YXNrIGlzIGNyZWF0ZWQgYnkgdGhlIGdvbGFuZyBjb2RlCgoKIyEvdXNyL2Jpbi9lbnYgYmFzaAoKaWYgWyAhIC16ICR7SkJTX0RJU0FCTEVfQ0FDSEUreH0gXTsgdGhlbgogICAgY2F0ID4iL3Jvb3Qvc29mdHdhcmUvc2V0dGluZ3MiL3NldHRpbmdzLnhtbCA8PEVPRgogICAgPHNldHRpbmdzPgpFT0YKZWxzZQogICAgY2F0ID4iL3Jvb3Qvc29mdHdhcmUvc2V0dGluZ3MiL3NldHRpbmdzLnhtbCA8PEVPRgogICAgPHNldHRpbmdzPgogICAgICA8bWlycm9ycz4KICAgICAgICA8bWlycm9yPgogICAgICAgICAgPGlkPm1pcnJvci5kZWZhdWx0PC9pZD4KICAgICAgICAgIDx1cmw+JHtDQUNIRV9VUkx9PC91cmw+CiAgICAgICAgICA8bWlycm9yT2Y+KjwvbWlycm9yT2Y+CiAgICAgICAgPC9taXJyb3I+CiAgICAgIDwvbWlycm9ycz4KRU9GCmZpCgpjYXQgPj4iL3Jvb3Qvc29mdHdhcmUvc2V0dGluZ3MiL3NldHRpbmdzLnhtbCA8PEVPRgogIDwhLS0gT2ZmIGJ5IGRlZmF1bHQsIGJ1dCBhbGxvd3MgYSBzZWNvbmRhcnkgTWF2ZW4gYnVpbGQgdG8gdXNlIHJlc3VsdHMgb2YgcHJpb3IgKGUuZy4gR3JhZGxlKSBkZXBsb3ltZW50IC0tPgogIDxwcm9maWxlcz4KICAgIDxwcm9maWxlPgogICAgICA8aWQ+Z3JhZGxlPC9pZD4KICAgICAgPGFjdGl2YXRpb24+CiAgICAgICAgPHByb3BlcnR5PgogICAgICAgICAgPG5hbWU+dXNlSkJTRGVwbG95ZWQ8L25hbWU+CiAgICAgICAgPC9wcm9wZXJ0eT4KICAgICAgPC9hY3RpdmF0aW9uPgogICAgICA8cmVwb3NpdG9yaWVzPgogICAgICAgIDxyZXBvc2l0b3J5PgogICAgICAgICAgPGlkPmFydGlmYWN0czwvaWQ+CiAgICAgICAgICA8dXJsPmZpbGU6Ly8vcm9vdC9wcm9qZWN0L2FydGlmYWN0czwvdXJsPgogICAgICAgICAgPHJlbGVhc2VzPgogICAgICAgICAgICA8ZW5hYmxlZD50cnVlPC9lbmFibGVkPgogICAgICAgICAgICA8Y2hlY2tzdW1Qb2xpY3k+aWdub3JlPC9jaGVja3N1bVBvbGljeT4KICAgICAgICAgIDwvcmVsZWFzZXM+CiAgICAgICAgPC9yZXBvc2l0b3J5PgogICAgICA8L3JlcG9zaXRvcmllcz4KICAgICAgPHBsdWdpblJlcG9zaXRvcmllcz4KICAgICAgICA8cGx1Z2luUmVwb3NpdG9yeT4KICAgICAgICAgIDxpZD5hcnRpZmFjdHM8L2lkPgogICAgICAgICAgPHVybD5maWxlOi8vL3Jvb3QvcHJvamVjdC9hcnRpZmFjdHM8L3VybD4KICAgICAgICAgIDxyZWxlYXNlcz4KICAgICAgICAgICAgPGVuYWJsZWQ+dHJ1ZTwvZW5hYmxlZD4KICAgICAgICAgICAgPGNoZWNrc3VtUG9saWN5Pmlnbm9yZTwvY2hlY2tzdW1Qb2xpY3k+CiAgICAgICAgICA8L3JlbGVhc2VzPgogICAgICAgIDwvcGx1Z2luUmVwb3NpdG9yeT4KICAgICAgPC9wbHVnaW5SZXBvc2l0b3JpZXM+CiAgICA8L3Byb2ZpbGU+CiAgPC9wcm9maWxlcz4KPC9zZXR0aW5ncz4KRU9GCgojIS91c3IvYmluL2VudiBiYXNoCgpta2RpciAtcCAiJHtIT01FfS8ubTIvcmVwb3NpdG9yeSIKI2NvcHkgYmFjayB0aGUgZ3JhZGxlIGZvbGRlciBmb3IgaGVybWV0aWMKY3AgLXIgL21hdmVuLWFydGlmYWN0cy8qICIkSE9NRS8ubTIvcmVwb3NpdG9yeS8iIHx8IHRydWUKCmVjaG8gIk1BVkVOX0hPTUU9JHtNQVZFTl9IT01FfSIKCmlmIFsgISAtZCAiJHtNQVZFTl9IT01FfSIgXTsgdGhlbgogICAgZWNobyAiTWF2ZW4gaG9tZSBkaXJlY3Rvcnkgbm90IGZvdW5kIGF0ICR7TUFWRU5fSE9NRX0iID4mMgogICAgZXhpdCAxCmZpCgpUT09MQ0hBSU5TX1hNTD0iL3Jvb3Qvc29mdHdhcmUvc2V0dGluZ3MiL3Rvb2xjaGFpbnMueG1sCgpjYXQgPiIkVE9PTENIQUlOU19YTUwiIDw8RU9GCjw/eG1sIHZlcnNpb249IjEuMCIgZW5jb2Rpbmc9IlVURi04Ij8+Cjx0b29sY2hhaW5zPgpFT0YKCmlmIFsgIjE3IiA9ICI3IiBdOyB0aGVuCiAgICBKQVZBX1ZFUlNJT05TPSI3OjEuNy4wIDg6MS44LjAgMTE6MTEiCmVsc2UKICAgIEpBVkFfVkVSU0lPTlM9Ijg6MS44LjAgOToxMSAxMToxMSAxNzoxNyAyMToyMSIKZmkKCmZvciBpIGluICRKQVZBX1ZFUlNJT05TOyBkbwogICAgdmVyc2lvbj0kKGVjaG8gJGkgfCBjdXQgLWQgOiAtZiAxKQogICAgaG9tZT0kKGVjaG8gJGkgfCBjdXQgLWQgOiAtZiAyKQogICAgY2F0ID4+IiRUT09MQ0hBSU5TX1hNTCIgPDxFT0YKICA8dG9vbGNoYWluPgogICAgPHR5cGU+amRrPC90eXBlPgogICAgPHByb3ZpZGVzPgogICAgICA8dmVyc2lvbj4kdmVyc2lvbjwvdmVyc2lvbj4KICAgIDwvcHJvdmlkZXM+CiAgICA8Y29uZmlndXJhdGlvbj4KICAgICAgPGpka0hvbWU+L3Vzci9saWIvanZtL2phdmEtJGhvbWUtb3BlbmpkazwvamRrSG9tZT4KICAgIDwvY29uZmlndXJhdGlvbj4KICA8L3Rvb2xjaGFpbj4KRU9GCmRvbmUKCmNhdCA+PiIkVE9PTENIQUlOU19YTUwiIDw8RU9GCjwvdG9vbGNoYWlucz4KRU9GCgoKaWYgWyAteiAiIiBdCnRoZW4KICBlY2hvICJFbmZvcmNlIHZlcnNpb24gbm90IHNldCwgc2tpcHBpbmciCmVsc2UKICBlY2hvICJTZXR0aW5nIHZlcnNpb24gdG8gIgogIG12biAtQiAtZSAtcyAiL3Jvb3Qvc29mdHdhcmUvc2V0dGluZ3Mvc2V0dGluZ3MueG1sIiAtdCAiL3Jvb3Qvc29mdHdhcmUvc2V0dGluZ3MvdG9vbGNoYWlucy54bWwiIG9yZy5jb2RlaGF1cy5tb2pvOnZlcnNpb25zLW1hdmVuLXBsdWdpbjoyLjguMTpzZXQgLURuZXdWZXJzaW9uPSIiICB8IHRlZSAvcm9vdC9wcm9qZWN0L2xvZ3MvZW5mb3JjZS12ZXJzaW9uLmxvZwpmaQoKCiNpZiB3ZSBydW4gb3V0IG9mIG1lbW9yeSB3ZSB3YW50IHRoZSBKVk0gdG8gZGllIHdpdGggZXJyb3IgY29kZSAxMzQKZXhwb3J0IE1BVkVOX09QVFM9Ii1YWDorQ3Jhc2hPbk91dE9mTWVtb3J5RXJyb3IiCgplY2hvICJSdW5uaW5nIE1hdmVuIGNvbW1hbmQgd2l0aCBhcmd1bWVudHM6ICRAIgoKaWYgWyAhIC1kIC9yb290L3Byb2plY3Qvc291cmNlIF07IHRoZW4KICBjcCAtciAvcm9vdC9wcm9qZWN0L3dvcmtzcGFjZSAvcm9vdC9wcm9qZWN0L3NvdXJjZQpmaQojd2UgY2FuJ3QgdXNlIGFycmF5IHBhcmFtZXRlcnMgZGlyZWN0bHkgaGVyZQojd2UgcGFzcyB0aGVtIGluIGFzIGdvYWxzCm12biAtViAtQiAtZSAtcyAiL3Jvb3Qvc29mdHdhcmUvc2V0dGluZ3Mvc2V0dGluZ3MueG1sIiAtdCAiL3Jvb3Qvc29mdHdhcmUvc2V0dGluZ3MvdG9vbGNoYWlucy54bWwiICIkQCIgIi1EYWx0RGVwbG95bWVudFJlcG9zaXRvcnk9bG9jYWw6OmZpbGU6L3Jvb3QvcHJvamVjdC9hcnRpZmFjdHMiIHwgdGVlIC9yb290L3Byb2plY3QvbG9ncy9tYXZlbi5sb2cKCmNwIC1yICIke0hPTUV9Ii8ubTIvcmVwb3NpdG9yeS8qIC9yb290L3Byb2plY3QvYnVpbGQtaW5mbwoKCgo= | base64 -d >/root/build.sh
RUN echo IyEvYmluL3NoCi9yb290L3ByZXByb2Nlc3Nvci5zaApjZCAvcm9vdC9wcm9qZWN0L3dvcmtzcGFjZQpleHBvcnQgTUFWRU5fSE9NRT0vb3B0L21hdmVuLzMuOS41CmV4cG9ydCBUT09MX1ZFUlNJT049My45LjUKZXhwb3J0IFBST0pFQ1RfVkVSU0lPTj0zLjEwLjAKZXhwb3J0IEpBVkFfSE9NRT0vbGliL2p2bS9qYXZhLTE3CmV4cG9ydCBFTkZPUkNFX1ZFUlNJT049Cgovcm9vdC9idWlsZC5zaCBpbnN0YWxsIC1EYWxsb3dJbmNvbXBsZXRlUHJvamVjdHMgLURhbmltYWwuc25pZmZlci5za2lwIC1EY2hlY2tzdHlsZS5za2lwIC1EY29iZXJ0dXJhLnNraXAgLURlbmZvcmNlci5za2lwIC1EZm9ybWF0dGVyLnNraXAgLURncGcuc2tpcCAtRGltcHNvcnQuc2tpcCAtRGphcGljbXAuc2tpcCAtRG1hdmVuLmphdmFkb2MuZmFpbE9uRXJyb3I9ZmFsc2UgLURtYXZlbi5zaXRlLmRlcGxveS5za2lwIC1EcGdwdmVyaWZ5LnNraXAgLURyYXQuc2tpcD10cnVlIC1EcmV2YXBpLnNraXAgLURzb3J0LnNraXAgLURzcG90YnVncy5za2lwIC1Ec2tpcFRlc3RzIG9yZy5hcGFjaGUubWF2ZW4ucGx1Z2luczptYXZlbi1kZXBsb3ktcGx1Z2luOjMuMS4xOmRlcGxveSAK | base64 -d >/root/run-full-build.sh
RUN echo IyEvYmluL2Jhc2gKIwojIFRoaXMgZmlsZSBpcyByZXF1aXJlZCBmb3IgdGhlIGRpYWdub3N0aWMgZG9ja2VyZmlsZXMgLSBzZWUgYnVpbGRyZWNpcGV5YW1sLmdvCgoKZWNobyAtZSAiRGlhZ25vc3RpYyBkb2NrZXIgZmlsZXMgYXJlIHN1cHBsaWVkIGZvciBlYWNoIGJ1aWxkLiBUaGUgRG9ja2VyZmlsZSBpcyBhIHNlbGYtY29udGFpbmVkIHVuaXQgdGhhdAphbGxvd3MgdGhlIHVzZXIgdG8gc3RhcnQgYSBjYWNoZSBhbmQgdGhlbiBwZXJmb3JtIGEgYnVpbGQgdXNpbmcgdGhlIHNhbWUgbWV0aG9kcyBhcyB0aGUgSmF2YSBCdWlsZApTZXJ2aWNlIChodHRwczovL2dpdGh1Yi5jb20vcmVkaGF0LWFwcHN0dWRpby9qdm0tYnVpbGQtc2VydmljZSkgdXNlcyBpbnRlcm5hbGx5LgoKXGVbMTszMm1UbyBwZXJmb3JtIGEgYnVpbGQsIGZpcnN0bHkgcnVuIHRoZSBmb2xsb3dpbmcgc2NyaXB0IHRvIHNldHVwIHRoZSBjYWNoZTpcZVswbQoKXGVbMTszM20uL3N0YXJ0LWNhY2hlLnNoXGVbMG0KClxlWzE7MzJtTmV4dCBydW4gKHdoaWNoIG1heSBiZSBydW4gcmVwZWF0ZWRseSBpZiByZXF1aXJlZCk6XGVbMG0KClxlWzE7MzNtLi9ydW4tZnVsbC1idWlsZC5zaFxlWzBtCiIKCi9iaW4vYmFzaCAiJEAiCg== | base64 -d >/root/entry-script.sh
RUN chmod +x /root/*.sh
CMD [ "/bin/bash", "/root/entry-script.sh" ]

ENV JBS_DISABLE_CACHE=true
RUN cp -ar /original-content/workspace /root/project/workspace && /root/run-full-build.sh
