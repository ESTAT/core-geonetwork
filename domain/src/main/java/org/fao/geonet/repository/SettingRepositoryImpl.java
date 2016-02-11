package org.fao.geonet.repository;

import static org.fao.geonet.domain.Constants.toYN_EnabledChar;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.TypedQuery;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.fao.geonet.domain.Setting;
import org.fao.geonet.domain.Setting_;
import org.springframework.dao.EmptyResultDataAccessException;

/**
 * Implementation for MetadataNotifierRepositoryCustom methods.
 * <p/>
 * User: francois
 * Date: 8/28/13
 * Time: 7:31 AM
 * To change this template use File | Settings | File Templates.
 */
public class SettingRepositoryImpl implements SettingRepositoryCustom {

    @PersistenceContext
    private EntityManager _entityManager;


    @Override
    public List<Setting> findAllByInternal(boolean internal) {

      CriteriaBuilder cb = _entityManager.getCriteriaBuilder();
      CriteriaQuery<Setting> cquery = cb.createQuery(Setting.class);
      Root<Setting> root = cquery.from(Setting.class);
      char internalChar = toYN_EnabledChar(internal);
      cquery.where(cb.equal(root.get(Setting_.internal_JpaWorkaround), internalChar));
      return _entityManager.createQuery(cquery).getResultList();
    }


    /**
     * @see org.fao.geonet.repository.SettingRepositoryCustom#findByKey(java.lang.String)
     * @param key
     * @return
     */
    @Override
    public Setting findByKey(String key) {

        CriteriaBuilder cb = _entityManager.getCriteriaBuilder();
        CriteriaQuery<Setting> cquery = cb.createQuery(Setting.class);
        Root<Setting> root = cquery.from(Setting.class);
        cquery.where(cb.equal(root.get(Setting_.name), key));
        Setting s = null;
        try{
            s = _entityManager.createQuery(cquery).getSingleResult();
        }catch(Throwable e) {
            
        }
        return s;
    }


    /**
     * @see org.fao.geonet.repository.SettingRepositoryCustom#findById(java.lang.Integer)
     * @param id
     * @return
     */
    @Override
    public String oldGet(Integer id) {
        Query q = _entityManager.createNativeQuery("SELECT value FROM settings where id = " + id);
        
        String s = null;
        try{
            s = q.getSingleResult().toString();
        }catch(Throwable e) {
            System.out.println(e.getMessage());
        }
        return s;
    }

}
