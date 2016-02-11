package org.fao.geonet.repository;

import java.util.List;

import org.fao.geonet.domain.Setting;

/**
 * The custom setting repository methods that can't be implemented by the spring-data api.
 * <p/>
 * User: francois
 * Date: 8/28/13
 * Time: 7:30 AM
 */
public interface SettingRepositoryCustom {
    /**
     * Find all the public/private settings
     *
     * @param private if true then  find the private
     */
    List<Setting> findAllByInternal(boolean internal);

    /**
     * Get the value by key
     * @param key
     * @return
     */
    Setting findByKey(String key);
    
    /**
     * Get the value by id
     * @param id
     * @return
     */
    @Deprecated
    String oldGet(Integer id);
}
