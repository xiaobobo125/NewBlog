package com.bolife.blog.util;

/**
 * @author Mr.BoBo
 * @create 2020-07-30 9:27
 */
public class ResultJSON {
    private Integer code;
    private String msg;
    private Object data;
    private Integer count;

    public ResultJSON(Integer code, String msg, Object data, Integer count) {
        this.code = code;
        this.msg = msg;
        this.data = data;
        this.count = count;
    }



    public ResultJSON() {
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getData() {
        return data;
    }

    public void setData(Object data) {
        this.data = data;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

}
