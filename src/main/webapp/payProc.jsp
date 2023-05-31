<%@page import="store.UtilMgr"%>
<%@page import="sale.saleBean"%>
<%@page import="store.cartBean"%>
<%@page import="java.util.Vector"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<jsp:useBean id="cMgr" class="store.cartMgr" />
<jsp:useBean id="storeMgr" class="store.storeMgr" />
<jsp:useBean id="saleMgr" class="sale.saleMgr" />
<%@page import="store.cartBean"%>
<%@page import="store.storeBean"%>


<%
System.out.println("payProc으로 넘어왔습니다.");      

int lastprice = 0; 		

		 String id = (String) session.getAttribute("idKey");
		 
		 System.out.println("### id : " + id);

		 request.setCharacterEncoding("UTF-8");
	     String name = String.valueOf(session.getAttribute("name"));
	     String email = String.valueOf(session.getAttribute("email"));
	     String phone = String.valueOf(session.getAttribute("phone"));
	     //String address = (String)request.getParameter("address");
	     String totalPrice = String.valueOf(session.getAttribute("totalPrice"));
	     
	     
	   //System.out.println("payProc)) name : " + name);
	    //System.out.println("payProc)) email : " + email);
	     //System.out.println("payProc)) phone : " + phone);
	     //System.out.println("payProc)) totalPrice : " + totalPrice);
	     
	     //int payAmt = Integer.parseInt(totalPrice);
	     int payAmt = 100;
	  
	     //System.out.println("##############################");
	     
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
    <script>
    $(function(){
        var IMP = window.IMP; // 생략가능
        IMP.init('iamport'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;
        
        IMP.request_pay({
            pg : 'inicis',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : '주문명:DEC결제진행',
            amount : <%=payAmt%>,
            buyer_email : '<%=email%>',
            buyer_name : '<%=name%>',
            buyer_tel : '<%=phone%>',
            
            buyer_postcode : '(051)123-456',
            m_redirect_url : 'http://www.naver.com'
        }, function(rsp) {
            if (rsp.success ) {
                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                jQuery.ajax({
                    url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid
                        //기타 필요한 데이터가 있으면 추가 전달
                    }
                }).done(function(data) {
                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                    if ( everythings_fine ) {
                        msg = '결제가 완료되었습니다.';
                        msg += '\n고유ID : ' + rsp.imp_uid;
                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                        msg += '\결제 금액 : ' + rsp.paid_amount;
                       /*  msg += '카드 승인번호 : ' + rsp.apply_num; */
                        alert(msg);
                    } else {
                        //[3] 아직 제대로 결제가 되지 않았습니다.
                        //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                    }
                });
                //성공시 이동할 페이지
               
                
                
                <%
                
                Vector<cartBean> vlist = cMgr.getCart(id);

                for (int i = 0; i < vlist.size(); i++) {
	                cartBean bean = vlist.get(i);
	                storeBean pbean = storeMgr.getProduct(bean.getProductNo());
	                int totalprice = bean.getQuantity() * pbean.getPrice();
	                lastprice += totalprice;
						                

	                saleBean salebean = new saleBean();
	                salebean.setId(id);
	                salebean.setProductNo(pbean.getIdx());
	                salebean.setPrice(pbean.getPrice());
	                salebean.setQuantity(bean.getQuantity());
	                
	                //결제될 시에 sale테이블에 들어가기 때문에 paystate는 삭제
	                //salebean.setPaystate(1);//결제 안된상태 = 0, 결제된 상태 = 1
	        		
	        		//결제 완료시 cart proc으로 귀환해서 sale 테이블에 결제정보 추가
	        		saleMgr.addSale(salebean);
                }
                
                
                boolean flag = cMgr.deleteCart(id);
                //System.out.println("flag : " + flag);
                %>
                
                <%-- location.href='<%=request.getContextPath()%>/pay/paymentProc.jsp?apply_num='+'123'+'&paid_amount='+rsp.paid_amount; --%>
                location.href='<%=request.getContextPath()%>/payResult.jsp';
               
               
            } else {
                msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                alert(msg);
                //실패시 이동할 페이지
                location.href="<%=request.getContextPath()%>/cart.jsp";
            }
        });
    });
    </script> 
</body>
</html>
