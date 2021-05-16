package com.gikim.mall;

import java.util.Arrays;

public class temp {
    public static void main(String[] args) {
        String[] arr1 = {"야구", "배구", "농구"};

        System.out.println(Arrays.stream(arr1).reduce((s1, s2)->s1+","+s2).get());

    }
}
