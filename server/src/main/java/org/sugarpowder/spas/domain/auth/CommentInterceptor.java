package org.sugarpowder.spas.domain.auth;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.HandlerMapping;
import org.sugarpowder.spas.domain.comment.CommentEntity;
import org.sugarpowder.spas.domain.comment.CommentService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Component
public class CommentInterceptor implements HandlerInterceptor {

    private final CommentService commentService;

    public CommentInterceptor(CommentService commentService) {
        this.commentService = commentService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Map<String, String> map = (Map<String, String>) request.getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
        String dayId = map.getOrDefault("commentId", null);
        String token = request.getHeader("Authorization");

        String method = request.getMethod();

        if (method.equals("PUT") || method.equals("DELETE")) {
            try {
                Long id = Long.parseLong(dayId);

                CommentEntity entity = commentService.getCommentById(id);
                if (!entity.getUserToken().equals(token)) throw new IllegalArgumentException("no auth comment");
            } catch (Exception e) {
                throw new IllegalArgumentException(e.getMessage());
            }
        }
        return true;
    }
}

