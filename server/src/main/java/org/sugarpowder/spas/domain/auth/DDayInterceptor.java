package org.sugarpowder.spas.domain.auth;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.HandlerMapping;
import org.sugarpowder.spas.domain.dayday.DDayEntity;
import org.sugarpowder.spas.domain.dayday.DDayService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Map;

@Component
public class DDayInterceptor implements HandlerInterceptor {

    private final DDayService dDayService;

    public DDayInterceptor(DDayService dDayService) {
        this.dDayService = dDayService;
    }

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        Map<String, String> map = (Map<String, String>) request.getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
        String dayId = map.getOrDefault("dayId", null);
        String token = request.getHeader("Authorization");

        String method = request.getMethod();

        if (method.equals("PUT") || method.equals("DELETE")) {
            try {
                Long id = Long.parseLong(dayId);

                DDayEntity entity = dDayService.getDdayById(id);
                if (!entity.getToken().equals(token)) throw new IllegalArgumentException("no auth dday");
            } catch (Exception e) {
                throw new IllegalArgumentException(e.getMessage());
            }
        }
        return true;
    }
}
