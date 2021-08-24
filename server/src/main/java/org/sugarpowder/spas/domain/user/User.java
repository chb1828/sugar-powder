package org.sugarpowder.spas.domain.user;

import com.fasterxml.jackson.annotation.JsonInclude;
import io.swagger.annotations.ApiModel;
import lombok.Data;
import org.sugarpowder.spas.domain.shared.dto.ApiResult;

import javax.validation.constraints.NotNull;

@Data
public class User extends ApiResult {
    private Long id;
    private String nickname;
    private String token;
    private String deviceToken;

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                ", nickname='" + nickname + '\'' +
                ", token='" + token + '\'' +
                ", deviceToken='" + deviceToken + '\'' +
                ", notiYn=" + notiYn +
                '}';
    }

    @JsonInclude(JsonInclude.Include.NON_NULL)
    private Boolean notiYn;

    @Data
    @ApiModel(value = "User.Create")
    public static class Create {
        @NotNull
        private String nickname;
        @NotNull
        private String token;
        @NotNull
        private String deviceToken;
        @NotNull
        private boolean notiYn;
    }

    @Data
    @ApiModel(value = "User.Update")
    public static class Update {
        @NotNull
        private String token;
        @NotNull
        private String nickname;
        @NotNull
        private String deviceToken;
        @NotNull
        private boolean notiYn;
    }

    @Data
    @ApiModel(value = "User.Delete")
    public static class Delete {
        private String token;
    }
}
