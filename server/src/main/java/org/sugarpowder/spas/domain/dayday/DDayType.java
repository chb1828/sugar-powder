package org.sugarpowder.spas.domain.dayday;

import io.swagger.annotations.ApiModel;

@ApiModel
public enum DDayType {
    PUBLIC("public"), PRIVATE("private");

    private String type;

    DDayType(String s) {
        this.type = s;
    }
}
