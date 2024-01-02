FROM ubuntu

ENV PASSWD="siry"
# 修改root密码为siry
RUN echo "root:${PASSWD}" | chpasswd \
    #  可以考虑用替换阿里源  这里@起到分隔符的作用
    && sed -i 's@archive.ubuntu.com@mirrors.aliyun.com@g' /etc/apt/sources.list \
    && sed -i 's@security.ubuntu.com@mirrors.aliyun.com@g' /etc/apt/sources.list \
    # 更新软件包表
    && apt update \
    # 安装vim, ubuntu镜像中不带, -y会自动确认所有提示,免得要手动输入yes
    && apt install vim -y \
    # 安装git
    && apt install -y git  \
    # 安装zsh
    && apt install -y zsh \
    && apt install -y curl \
    # 安装oh-my-zsh
    && sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
    # 安装zsh插件 高亮
    && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting \
    # 建议
    && git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions \
    # 添加插件进.zshrc文件  这里/起到分隔符的作用
    && sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/' ~/.zshrc \
    # 安装fnm之前安装unzip, == 有时候可能安装不上吧
    && apt install -y unzip \
    # 安装fnm
    && curl -fsSL https://fnm.vercel.app/install | bash \
    &&  echo 'export PATH="/root/.local/share/fnm:$PATH"' >> /root/.zshrc \
    &&  echo 'eval "`fnm env`"' >> /root/.zshrc \
    # 安装nvm
    # && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash \
    # 写入到zsh配置文件, 默认是写到了bash的配置文件中
    # && echo 'export NVM_DIR="$HOME/.nvm" \n\
    #     [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  \n\
    #     [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"' >> ~/.zshrc \
    # 安装rust环境
    && curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y \
    # 安装golang环境
    && apt install -y golang-go \
    # 安装brew
    && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
    # 安装之后需要写入环境变量
    && (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /root/.zshrc \
    && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)" 
# 启动容器时默认执行 Zsh shell
CMD ["zsh"]

