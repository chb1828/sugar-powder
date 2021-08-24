package org.sugarpowder.spas.infrastructure.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.sugarpowder.spas.domain.auth.CommentInterceptor;
import org.sugarpowder.spas.domain.auth.DDayInterceptor;
import org.sugarpowder.spas.domain.comment.CommentService;
import org.sugarpowder.spas.domain.dayday.DDayService;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    private final DDayService dayService;
    private final CommentService commentService;

    public WebConfig(DDayService dayService, CommentService commentService) {
        this.dayService = dayService;
        this.commentService = commentService;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new DDayInterceptor(dayService))
                .addPathPatterns("/api/dday/**");
        registry.addInterceptor(new CommentInterceptor(commentService))
                .addPathPatterns("/api/comments/**");
    }

//    @Bean
//    public ObjectMapper objectMapper() {
//        ObjectMapper mapper = new ObjectMapper()
//                .registerModule(new ParameterNamesModule())
//                .registerModule(new Jdk8Module())
//                .registerModule(new JavaTimeModule());
//
//        mapper.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false);
//
//        return mapper;
//    }
}
