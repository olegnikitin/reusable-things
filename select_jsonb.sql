SELECT q.settings || jsonb_build_object(
    'view_settings',
    (
    SELECT
        jsonb_agg(CASE
        WHEN viewSetting->>'hash' = 'balance'
        THEN viewSetting ||
            jsonb_build_object(
                'fields',
                viewSetting->'fields' || '[{"hash":"is_hide_with_financing", "value":false}]'::jsonb
            )
        ELSE viewSetting
        END)
    FROM jsonb_array_elements(q.settings->'view_settings') viewSetting
    )
) FROM quote_price_presentations q
