package org.sugarpowder.spas.domain.dayday;

import io.swagger.annotations.ApiModel;

@ApiModel
public enum DaySort {
    CREATE("CREATE"), FOLLOW_COUNT("FOLLOW_COUNT"), NEAREST("NEAREST");

    private String type;

    DaySort(String s) {
        this.type = s;
    }
}
