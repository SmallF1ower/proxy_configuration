# proxy_configuration

## Why?
因为学习V8的时候，需要编译V8  
而当时只使用了socks5代理，导致了一堆报错，google和baidu并没有找到原因和解决方法 (比如：我在使用depot_tools的时候总会出一个stl证书错)  
所以我在花大量的时间解决了代理问题之后，建立了这个小项目意在帮助自己和需要的师傅方便的搞好代理环境，提升效率  

## Installation
```
git clone https://github.com/SmallF1ower/proxy_configuration.git
cd proxy_configuration
chmod +x configuration.sh
./configuration.sh
```
脚本运行中，会直接执行ssr config  
其实就是vim打开~/.local/share/shadowsocksr/config.json：  
```
{
    "server": "0.0.0.0",
    "server_ipv6": "::",
    "server_port": 8388,
    "local_address": "127.0.0.1",
    "local_port": 1080,

    "password": "m",
    "method": "aes-128-ctr",
    "protocol": "auth_aes128_md5",
    "protocol_param": "",
    "obfs": "tls1.2_ticket_auth_compatible",
    "obfs_param": "",
    "speed_limit_per_con": 0,
    "speed_limit_per_user": 0,

    "additional_ports" : {}, // only works under multi-user mode
    "additional_ports_only" : false, // only works under multi-user mode
    "timeout": 120,
    "udp_timeout": 60,
    "dns_ipv6": false,
    "connect_verbose_info": 0,
    "redirect": "",
    "fast_open": false
}
```
在这个配置文件中填上你速度最快的ssr节点，然后:wq出来即可完成  
其实这时候已经安装完成了，但为了更加方便使用  
```
vim ~/.zshrc
```
在结尾处加入以下的代码：  
```
proxy () {
        export all_proxy=socks5://127.0.0.1:1080
        echo "All Proxy On"
}
unproxy () {
        unset all_proxy
        echo "All Proxy Off"
}
git_proxy () {
        git config --global http.proxy 'http://127.0.0.1:8123'
        git config --global https.proxy 'http://127.0.0.1:8123'
        echo "Git Proxy Set"
}
ungit_proxy() {
        git config --global --unset http.proxy
        git config --global --unset https.proxy
        echo "Git Proxy Unset"
}
proxy_check () {
        echo "allproxy, your ip addr: "
        curl ifconfig.co
        echo "git proxy situation: "
        echo "git http.proxy: `git config --global --get http.proxy`"
        echo "git https.proxy: `git config --global --get https.proxy`"
}
```
最后需要：
```
source ~/.zshrc
```

## Usage
```
ssr start                   /*
sudo service polipo start   start server */

ssr stop                    /*
sudo service polipo stop    start server */

proxy       //开启代理(all_proxy),仅在当前command line生效
unproxy     //关闭代理(all_proxy),进在当前command line生效
git_proxy   //配置git代理,永久生效
ungit_proxy //清除git代理,永久生效
proxy_check //检查当前command line的代理情况(返回一个ip和git的代理情况)
```
## Testing
*我只在Ubuntu18.04.3和Ubuntu16.04.6做过测试，安装及使用情况正常*  
*理论上来说支持所有以apt为包管理器的Linux发行版本*  

## BUG
目前已知的错误是：
- 在ssr config(输入了配置文件之后)报错json格式问题  
    原因：可能是由于安装了jq导致解析配置文件错误  
    处理方法：去掉~/.local/share/shadowsocksr/config.json中的所有注释,保证json格式的正确  

## Note
对于任何问题或者反馈，请随时在此处创建issue或者通过Twitter[与我联系](https://twitter.com/samren0215)