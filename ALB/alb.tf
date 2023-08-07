provider "aws" {
  region = "us-east-2"
}

resource "aws_lb" "ss-ALB" {
  name               = "ss-ALB"
  load_balancer_type = "application"
  subnets            = ["subnet-073ea4b1f8eb4b623", "subnet-07f840e7ea698c69b"]

  tags = {
    Name = "ss-ALB"
  }
}


resource "aws_lb_listener" "http_listener" {
  load_balancer_arn = aws_lb.ss-ALB.arn
  port              = 80
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ss-tg.arn
  }
}
resource "aws_lb_listener" "tcp_listener" {
  load_balancer_arn = aws_lb.ss-ALB.arn
  port              = 3000
  protocol          = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ss-tg-2.arn
  }
}
resource "aws_lb_target_group" "ss-tg" {
  name     = "ss-tg-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-00be855b085ce5d52"
  
  health_check {
    path                = "/health"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 10
    healthy_threshold   = 3
    unhealthy_threshold = 3
  }
}

resource "aws_lb_target_group" "ss-tg-2" {
  name        = "ss-tg-2-target-group"
  target_type = "instance"
  port        = 3000
  protocol    = "HTTP"
  vpc_id      = "vpc-00be855b085ce5d52"

 }
