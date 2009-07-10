# thread_win32_convert.pl
# Read file specified in first argument, complete operations, write to file specified in second argument.

open(INPUT, "<$ARGV[0]") or die;
@input_array = <INPUT>;
close(INPUT);

# load in the complete file
$input_scalar = join("", @input_array);

# 4 patterns to match:

# line 315 in is_listen_thread()
# -    return pthread_self() == threads[0].thread_id;
# +    pthread_t tid = pthread_self();
# +    return(tid.p == threads[0].thread_id.p && tid.x == threads[0].thread_id.x);
$input_scalar =~ s#return pthread_self\(\) == threads\[0\]\.thread_id;#pthread_t tid = pthread_self\(\);\n    return\(tid\.p == threads\[0\]\.thread_id\.p && tid\.x == threads\[0\]\.thread_id\.x\);#g;

# line 574 in thread_init()
# -void thread_init(int nthreads, struct event_base *main_base) {
# +void thread_init(int nthreads, struct event_base *main_base) {
# +    struct sockaddr_in serv_addr;
# +    int sockfd;
# +    if ((sockfd = createLocalListSock(&serv_addr)) < 0)
# +        exit(1);
$input_scalar =~ s#void thread_init\(int nthreads, struct event_base \*main_base\) \{#void thread_init\(int nthreads, struct event_base \*main_base\) \{\n    struct sockaddr_in serv_addr;\n    int sockfd;\n    if \(\(sockfd = createLocalListSock\(\&serv_addr\)\) < 0\)\n        exit\(1\);#g;

# line 597 in thread_init()
# -        if (pipe(fds)) {
# +        if (createLocalSocketPair(sockfd,fds,&serv_addr) == -1) {
$input_scalar =~ s#\(pipe\(fds\)\)#\(createLocalSocketPair\(sockfd,fds,\&serv_addr\) == -1\)#g;

# line 605 in thread_init()
# +        setup_thread(&threads[i]); 
# +        setup_thread(&threads[i]); 
# +        if (i == (nthreads - 1)) shutdown(sockfd,2);
$input_scalar =~ s#setup_thread\(\&threads\[i\]\)\;#setup_thread\(\&threads\[i\]\)\;\n        if \(i == \(nthreads - 1\)\) shutdown\(sockfd,2\);#g;

open(OUTPUT, ">$ARGV[1]") or die;
print(OUTPUT $input_scalar);
close(OUTPUT);

