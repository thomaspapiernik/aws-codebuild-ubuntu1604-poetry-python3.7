A docker image to use with AWS CodeBuild to produice artifacts of your project

Tools and OS included :

| Name   | Version |
| ------ | ------- |
| poetry | latest  |
| Ubuntu | 16.04   |
| python | 3.7.4   |



## AWS CodeBuild local

To run AWS CodeBuild from local, first you need to install [codebuild_build.sh](https://raw.githubusercontent.com/aws/aws-codebuild-docker-images/master/local_builds/codebuild_build.sh)

Next invoke codebuild_build.sh like this:

```shell
 ./codebuild_build.sh -i aws-codebuild-ubuntu1604-python37 -a <artifact directory>
```

