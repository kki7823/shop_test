package com.gikim.mall;

import java.util.Hashtable;

public class CartMgr {

    private Hashtable<Integer,OrderBean> hCart = new Hashtable<>();

    public void addCart(OrderBean order){
        int productNo = order.getProductNo();
        int quantity = order.getQuantity();
        System.out.println("id: "+order.getId()+" quant: "+quantity+" prodno : "+productNo);

        if(quantity > 0){
            if(hCart.containsKey(productNo)){
                OrderBean temp = hCart.get(productNo);
                quantity += temp.getQuantity();
                order.setQuantity(quantity);
                hCart.put(productNo,order);
            }else {
                hCart.put(productNo, order);
            }
        }
    }

    public void updateCart(OrderBean order){
        int productNo = order.getProductNo();
        hCart.put(productNo,order);
    }

    public void deleteCart(OrderBean order){
        int producNo = order.getProductNo();
        hCart.remove(producNo);
    }

    public Hashtable<Integer, OrderBean> getCartList(){
        return hCart;
    }

}
