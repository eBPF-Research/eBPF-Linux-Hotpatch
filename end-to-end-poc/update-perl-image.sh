if ! (
    perl -MCPAN -e 'CPAN::HandleConfig->load();' \
        -e 'CPAN::HandleConfig->prettyprint("urllist")' |
    grep -qF 'https://mirrors.tuna.tsinghua.edu.cn/CPAN/'
); then
    perl -MCPAN -e 'CPAN::HandleConfig->load();' \
        -e 'CPAN::HandleConfig->edit("urllist", "unshift", "https://mirrors.tuna.tsinghua.edu.cn/CPAN/");' \
        -e 'CPAN::HandleConfig->commit()'
fi

perl -MCPAN -e 'CPAN::HandleConfig->load();' \
    -e 'CPAN::HandleConfig->edit("pushy_https", 0);' \
    -e 'CPAN::HandleConfig->commit()'
