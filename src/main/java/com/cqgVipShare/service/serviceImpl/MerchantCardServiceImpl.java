package com.cqgVipShare.service.serviceImpl;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cqgVipShare.dao.*;
import com.cqgVipShare.entity.*;
import com.cqgVipShare.service.*;
import com.cqgVipShare.util.JsonUtil;
import com.cqgVipShare.util.PlanResult;

@Service
public class MerchantCardServiceImpl implements MerchantCardService {

	@Autowired
	private MerchantMapper merchantDao;
	@Autowired
	private MerchantCardMapper merchantCardDao;
	private String[] merCardType=new String[] {"年卡","季卡","月卡","充值卡","次卡"};
	
	@Override
	public List<MerchantCard> selectList(Integer orderFlag, String order, Integer likeFlag, String shopId, Integer type, Integer start, Integer end, Double myLatitude, Double myLongitude) {
		// TODO Auto-generated method stub
		return merchantCardDao.selectList(orderFlag, order, likeFlag, shopId, type, start, end, myLatitude, myLongitude);
	}

	@Override
	public Map<String, Object> selectMapById(String id) {
		// TODO Auto-generated method stub

		Map<String, Object> map=new HashMap<String, Object>();
		MerchantCard mc = merchantCardDao.selectById(id);
		
		Integer shopId = mc.getShopId();
		Merchant mer=merchantDao.getById(shopId);

		map.put("id", mc.getId());
		map.put("logo", mer.getLogo());
		map.put("shopName", mer.getShopName());
		map.put("shopAddress", mer.getShopAddress());
		map.put("mcName", mc.getName());
		map.put("mcType", mc.getType());
		map.put("consumeCount", mc.getConsumeCount());
		map.put("money", mc.getMoney());
		map.put("discount", mc.getDiscount());
		map.put("describe", mc.getDescribe());
		map.put("gmxz", mc.getGmxz());
		return map;
	}

	@Override
	public MerchantCard selectById(String id) {
		// TODO Auto-generated method stub
		return merchantCardDao.selectById(id);
	}

	@Override
	public boolean compareShopIdWithCardShopId(String shopOpenId, Integer mcId) {
		// TODO Auto-generated method stub
		int cardShopId = merchantCardDao.selectShopIdById(mcId);
		int shopId = merchantDao.getShopIdByOpenId(shopOpenId);
		return cardShopId==shopId?true:false;
	}

	@Override
	public int selectForInt(String name, Integer type, Integer shopId) {
		// TODO Auto-generated method stub
		return merchantCardDao.selectForInt(name, type, shopId);
	}

	@Override
	public List<MerchantCard> selectList(String name, Integer type, Integer shopId, int page, int rows, String sort, String order) {
		// TODO Auto-generated method stub
		return merchantCardDao.selectBgList(name, type, shopId, (page-1)*rows, rows, sort, order);
	}

	@Override
	public int add(MerchantCard mc) {
		// TODO Auto-generated method stub
		return merchantCardDao.add(mc);
	}

	@Override
	public int edit(MerchantCard mc) {
		// TODO Auto-generated method stub
		return merchantCardDao.edit(mc);
	}

	@Override
	public boolean checkTypeExist(Integer type, Integer shopId) {
		// TODO Auto-generated method stub
		int count=merchantCardDao.getTypeCount(type, shopId);
		return count==0?false:true;
	}

	@Override
	public int updateEnableById(Integer id, Boolean enable) {
		// TODO Auto-generated method stub
		return merchantCardDao.updateEnableById(id,enable);
	}

	@Override
	public int deleteByIds(String ids) {
		// TODO Auto-generated method stub
		int count=0;
		List<String> idList = Arrays.asList(ids.split(","));
		count=merchantCardDao.deleteByIds(idList);
		return count;
	}

	@Override
	public String checkExistMerCardByType(String types, Integer shopId) {
		// TODO Auto-generated method stub
		PlanResult plan=new PlanResult();
		String msg="";
		String typesData="";
		String json=null;
		String[] typeArr = types.split(",");
		for (String type : typeArr) {
			int count=merchantCardDao.getCountByType(type,shopId);
			if(count>0) {
				msg+=","+merCardType[Integer.valueOf(type)-1];
			}
			else {
				typesData+=","+type;
			}
		}
		if(StringUtils.isEmpty(msg)) {
			plan.setStatus(1);
			typesData=typesData.substring(1);
			plan.setData(typesData);
			json=JsonUtil.getJsonFromObject(plan);
		}
		else {
			plan.setStatus(0);
			msg+="类型下存在会员卡，请到会员卡列表下先删除该类型下的会员卡。";
			if(!StringUtils.isEmpty(typesData)) {
				msg+="是否删除其他卡类型？";
				typesData=typesData.substring(1);
				plan.setData(typesData);
			}
			plan.setMsg(msg.substring(1));
			json=JsonUtil.getJsonFromObject(plan);
		}
		return json;
	}

	@Override
	public List<MerchantCard> selectList(String name, Integer type, Integer shopId) {
		// TODO Auto-generated method stub
		return merchantCardDao.selectMineMerBgList(name, type, shopId);
	}

	@Override
	public List<MerchantCard> selectList(Integer type, Integer shopId) {
		// TODO Auto-generated method stub
		return merchantCardDao.selectMerCardSel(type,shopId);
	}

}
