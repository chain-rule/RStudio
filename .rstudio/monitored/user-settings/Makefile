all:
	uiPrefs=$$( \
		cat user-settings-uiPrefs.json | \
		paste -sd ' ' - | \
		tr -s ' ' | \
		sed 's/"/\\"/g'\
	) && \
	echo "uiPrefs=\"$${uiPrefs}\"" >> user-settings

.PHONY: all
